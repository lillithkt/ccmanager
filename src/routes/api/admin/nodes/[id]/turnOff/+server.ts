import { Direction } from '$lib/types/direction';
import type { RequestHandler } from '@sveltejs/kit';

export const POST: RequestHandler = async ({ locals, request }) => {
	if (!locals.node) {
		return new Response('Node not found', { status: 404 });
	}

	const direction = (await request.text()) as Direction;
	if (!direction || !Object.values(Direction).includes(direction)) {
		return new Response('Invalid direction', { status: 400 });
	}

	locals.node.turnOff(direction);
	return new Response('Turned Off', { status: 200 });
};
