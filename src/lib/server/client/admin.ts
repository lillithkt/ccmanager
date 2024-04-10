import { ServerPacketType } from '$lib/packets/server';
import { Client } from '.';
import type { ExtendedWebSocket } from '../websocket/server';

export class Admin extends Client {
	constructor(ws: ExtendedWebSocket, name: string, id: number, debug = false, turtle: boolean) {
		super(ws, name, id, debug, turtle);

		this.on(ServerPacketType.Move, (data) => {
			this.ws.wss.nodes.get(data.id)?.move(data.direction);
		});

		this.on(ServerPacketType.Dig, (data) => {
			this.ws.wss.nodes.get(data.id)?.dig(data.direction);
		});

		this.on(ServerPacketType.Refuel, (id) => {
			this.ws.wss.nodes.get(id)?.refuel();
		});
	}
}
