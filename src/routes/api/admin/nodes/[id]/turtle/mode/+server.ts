import { ClientPacketType, type ClientPacketData } from '$lib/packets/client';
import { text, type RequestHandler } from '@sveltejs/kit';

export const POST: RequestHandler = async ({ request, locals }) => {
	const packet = (await request.json()) as ClientPacketData[ClientPacketType.TurtleMode];
	if (!locals.node) {
		return text('Node not found', { status: 404 });
	}

	locals.node.send(ClientPacketType.TurtleMode, packet);
	return text('OK');
};
