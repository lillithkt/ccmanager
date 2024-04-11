import { ClientPacketType } from '$lib/packets/client';
import { text, type RequestHandler } from '@sveltejs/kit';

export const POST: RequestHandler = async ({ locals }) => {
	const numUpdated = locals.wss.nodes.size + locals.wss.admins.size;
	for (const client of [...locals.wss.nodes.values(), ...locals.wss.admins.values()]) {
		client.send(ClientPacketType.Update, {});
	}

	return text(numUpdated.toString());
};
