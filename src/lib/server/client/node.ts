import { ClientPacketType, type ClientPacket } from '$lib/packets/client';
import type { ServerPacket, ServerPacketType } from '$lib/packets/server';
import type { Direction, TurtleDirection } from '$lib/types/direction';
import type { ExtendedWebSocket } from '../websocket/server';
import { Client } from './';

export class Node extends Client {
	toggle(direction: Direction) {
		this.send(ClientPacketType.Toggle, direction);
	}

	turnOn(direction: Direction) {
		this.send(ClientPacketType.TurnOn, direction);
	}

	turnOff(direction: Direction) {
		this.send(ClientPacketType.TurnOff, direction);
	}

	move(direction: TurtleDirection) {
		this.send(ClientPacketType.Move, direction);
	}

	dig(direction: TurtleDirection) {
		this.send(ClientPacketType.Dig, direction);
	}

	refuel() {
		this.send(ClientPacketType.Refuel, {});
	}

	constructor(
		ws: ExtendedWebSocket,
		name: string,
		id: number,
		debug = false,
		turtle: boolean = false
	) {
		super(ws, name, id, debug, turtle);

		const reportToAdmins = (
			packet: ClientPacket[ClientPacketType] | ServerPacket[ServerPacketType],
			toServer: boolean
		) => {
			if (this.debug) {
				for (const admin of this.ws.wss.admins.values()) {
					admin.send(ClientPacketType.AdminNodePacket, {
						node: this.serializable,
						toServer,
						packet
					});
				}
			}
		};
		this.on('packet', (packet) => {
			reportToAdmins(packet, true);
		});

		this.on('packetOut', (packet) => {
			reportToAdmins(packet, false);
		});
	}
}
