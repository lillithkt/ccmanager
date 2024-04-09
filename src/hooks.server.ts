import { building } from '$app/environment';
import serverConfig from '$lib/config';
import { ClientPacketType } from '$lib/packets/client';
import { ServerPacketType, type ServerPacket, type ServerPacketData } from '$lib/packets/server';
import { Node } from '$lib/server/client/node';
import type { ExtendedGlobal } from '$lib/server/websocket/server';
import { GlobalThisWSS } from '$lib/server/websocket/server';
import { ClientType } from '$lib/types';
import type { Handle } from '@sveltejs/kit';

// This can be extracted into a separate file
let wssInitialized = false;
const startupWebsocketServer = () => {
	if (wssInitialized) return;
	console.log('[wss:kit] setup');
	const wss = (globalThis as ExtendedGlobal)[GlobalThisWSS];
	if (wss !== undefined) {
		wss.on('connection', (ws) => {
			// This is where you can authenticate the client from the request
			// const session = await getSessionFromCookie(request.headers.cookie || '');
			// if (!session) ws.close(1008, 'User not authenticated');
			// ws.userId = session.userId;
			console.log(`[wss:kit] client connected (${ws.socketId})`);

			ws.on('close', (_: unknown, code: number, reason: string) => {
				console.log(
					`[wss:kit] client disconnected (${ws.socketId}) with code ${code} and reason ${reason}`
				);
			});

			ws.once('message', (message) => {
				const packet = JSON.parse(message.toString()) as ServerPacket[ServerPacketType];

				if (packet.type !== ServerPacketType.Register) {
					ws.send(
						JSON.stringify({
							type: ClientPacketType.Register,
							data: {
								success: false,
								message: 'Invalid packet type'
							}
						})
					);
					ws.close(1008, 'Invalid packet type');
					return;
				}

				const data = packet.data as ServerPacketData[ServerPacketType.Register];

				switch (data.type) {
					case ClientType.Node: {
						ws.type = ClientType.Node;
						const node = new Node(ws, data.name, data.id, data.debug || false);
						ws.item = node;

						if (data.password !== serverConfig.passwords.node) {
							node.send(ClientPacketType.Register, {
								success: false,
								message: 'Invalid password'
							});
							ws.close(1008, 'Invalid password');
							return;
						}

						wss.nodes.set(ws.item.id, node);

						node.send(ClientPacketType.Register, {
							success: true
						});

						node.on('close', () => {
							wss.nodes.delete(node.id);
						});

						break;
					}

					default:
						ws.send(
							JSON.stringify({
								error: 'Invalid client type'
							})
						);
						ws.close(1008, 'Invalid client type');
						return;
				}
			});
		});

		wssInitialized = true;
	}
};

export const handle = (async ({ event, resolve }) => {
	startupWebsocketServer();
	// Skip WebSocket server when pre-rendering pages
	if (!building) {
		const wss = (globalThis as ExtendedGlobal)[GlobalThisWSS];
		if (wss !== undefined) {
			event.locals.wss = wss;

			if (event.url.pathname.startsWith('/api/admin/nodes')) {
				let node = wss.nodes.get(Number(event.params.id));
				if (!node) {
					for (const n of wss.nodes.values()) {
						if (n.name === event.params.id) {
							node = n;
							break;
						}
					}
				}
				if (node) {
					event.locals.node = node;
				}
			}
		}
	}

	const response = await resolve(event, {
		filterSerializedResponseHeaders: (name) => name === 'content-type'
	});
	return response;
}) satisfies Handle;
