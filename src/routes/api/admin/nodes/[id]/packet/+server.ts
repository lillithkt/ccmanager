import type { ClientPacket, ClientPacketType } from '$lib/packets/client';
import { text, type RequestHandler } from '@sveltejs/kit';

export const POST: RequestHandler = async ({ locals, request }) => {
	if (!locals.node) {
		return text('Node not found', { status: 404 });
	}

	const body: ClientPacket[ClientPacketType] = await request.json();

	locals.node.send(body.type, body.data);

	return text('OK');
};
