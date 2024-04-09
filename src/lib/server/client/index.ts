import { ClientPacketType, type ClientPacketData } from '$lib/packets/client';
import { ServerPacketType, type ServerPacket, type ServerPacketData } from '$lib/packets/server';
import type { ExtendedWebSocket } from '$lib/server/websocket/server';
import { SerializableClient } from '$lib/types/client';

export class Client implements SerializableClient {
	name: string;
	id: number;
	ws: ExtendedWebSocket;
	debug: boolean;

	get serializable(): SerializableClient {
		return new SerializableClient(this);
	}

	// eslint-disable-next-line @typescript-eslint/no-explicit-any
	listeners: Map<string, Map<number, (...args: any[]) => void>> = new Map();

	heartbeats: number[] = [];

	constructor(ws: ExtendedWebSocket, name: string, id: number, debug = false) {
		this.ws = ws;
		this.name = name;
		this.id = id;
		this.debug = debug;

		this.ws.on('close', (code, reason) => {
			this.emit('close', code, reason);
		});

		this.ws.on('message', (message) => {
			const packet = JSON.parse(message.toString()) as ServerPacket[ServerPacketType];
			if (this.debug) {
				console.log(`Node ${this.name} (${this.id}) Received`, packet);
			}
			this.emit(packet.type, packet.data);
		});

		setInterval(() => {
			if (this.ws.readyState !== this.ws.OPEN) {
				return;
			}
			console.log(this.heartbeats);
			const now = Date.now();
			this.send(ClientPacketType.Heartbeat, now);
			this.heartbeats.push(now);

			if (this.heartbeats.length > 10) {
				this.close(1008, 'Heartbeat timeout');
			}
		}, 1000);

		this.on(ServerPacketType.Heartbeat, (data) => {
			this.heartbeats = this.heartbeats.filter((heartbeat) => heartbeat > data);
		});
	}

	send<T extends ClientPacketType>(type: T, data: ClientPacketData[T]) {
		if (this.ws.readyState !== this.ws.OPEN) {
			return;
		}
		if (this.debug) {
			console.log(`Node ${this.name} (${this.id}) Sent`, { type, data });
		}
		this.ws.send(
			JSON.stringify({
				type,
				data
			})
		);
	}

	eval(code: string): Promise<ServerPacketData[ServerPacketType.Eval]> {
		const now = Date.now();
		return new Promise((resolve, reject) => {
			this.send(ClientPacketType.Eval, {
				nonce: now,
				code
			});
			const onId = this.on(ServerPacketType.Eval, (data) => {
				if (data.nonce === now) {
					this.off(ServerPacketType.Eval, onId);
					if (data.success) {
						resolve(data.output);
					} else {
						reject(data.output);
					}
				}
			});
		});
	}

	emit(event: 'close', code: number, reason: string): void;
	emit<T extends ServerPacketType>(type: T, data: ServerPacketData[T]): void;
	emit(event: string, ...args: unknown[]): void;
	// eslint-disable-next-line @typescript-eslint/no-explicit-any
	emit(event: string, ...args: any[]) {
		this.listeners.get(event)?.forEach((callback) => callback(...args));
	}

	on(event: 'close', callback: (code: number, reason: string) => void): number;
	on<T extends ServerPacketType>(type: T, callback: (data: ServerPacketData[T]) => void): number;
	on(event: string, callback: (...args: unknown[]) => void): number;
	// eslint-disable-next-line @typescript-eslint/no-explicit-any
	on(event: string, callback: (...args: any[]) => void): number {
		const listeners = this.listeners.get(event) || new Map();
		const id = Math.random();
		listeners.set(id, callback);
		this.listeners.set(event, listeners);
		return id;
	}

	once(event: 'close', callback: (code: number, reason: string) => void): number;
	once<T extends ServerPacketType>(type: T, callback: (data: ServerPacketData[T]) => void): number;
	// eslint-disable-next-line @typescript-eslint/no-explicit-any
	once(event: string, callback: (...args: any[]) => void): number;
	// eslint-disable-next-line @typescript-eslint/no-explicit-any
	once(event: string, callback: (...args: any[]) => void): number {
		const id = this.on(event, (...args) => {
			this.off(event, id);
			callback(...args);
		});
		return id;
	}

	off(event: 'close', id: number): void;
	off<T extends ServerPacketType>(type: T, id: number): void;
	off(event: string, id: number): void;
	off(event: string, id: number) {
		const listeners = this.listeners.get(event);
		if (listeners) {
			listeners.delete(id);
		}
	}

	close(code: number, reason: string) {
		this.ws.close(code, reason);
	}
}
