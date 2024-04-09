import { ClientPacketType } from '$lib/packets/client';
import type { RequestHandler } from '@sveltejs/kit';

export const POST: RequestHandler = async ({ locals }) => {
	const numUpdated = locals.wss.nodes.size;
	for (const client of locals.wss.nodes.values()) {
		client.send(ClientPacketType.Update, {});
	}

	return new Response(numUpdated.toString(), { status: 200 });
};
