import { ServerPacketType } from '$lib/packets/server';
import { Client } from '.';
import type { ExtendedWebSocket } from '../websocket/server';

export class Admin extends Client {
	constructor(
		ws: ExtendedWebSocket,
		name: string,
		id: number,
		debug = false,
		turtle: boolean,
		command: boolean
	) {
		super(ws, name, id, debug, turtle, command);

		this.on(ServerPacketType.Move, (data) => {
			this.ws.wss.getNode(data.id)?.move(data.direction);
		});

		this.on(ServerPacketType.Dig, (data) => {
			this.ws.wss.getNode(data.id)?.dig(data.direction);
		});

		this.on(ServerPacketType.Refuel, (id) => {
			this.ws.wss.getNode(id)?.refuel();
		});
	}
}
