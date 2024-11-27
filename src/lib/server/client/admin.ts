import { ServerPacketType, type ServerPacketData } from '$lib/packets/server';
import type { Server } from 'http';
import { Client } from '.';
import type { ExtendedWebSocket } from '../websocket/server';

export class Admin extends Client {
	constructor(
		ws: ExtendedWebSocket,
		name: string,
		id: number,
		debug = false,
		turtle: boolean,
		command: boolean,
		tardis: boolean
	) {
		super(ws, name, id, debug, turtle, command, tardis);

		this.on(ServerPacketType.Packet, (data: ServerPacketData[ServerPacketType.Packet]) => {
			this.ws.wss.getNode(data.node)?.send(data.packet.type, data.packet.data);
		});
	}
}
