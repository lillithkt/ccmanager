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

		this.on(ServerPacketType.Packet, (data) => {
			this.ws.wss.getNode(data.node)?.send(data.packet.type, data.packet.data);
		});
	}
}
