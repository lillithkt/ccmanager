import { Direction } from '$lib/types/direction';
import type { RequestHandler } from '@sveltejs/kit';

export const POST: RequestHandler = async ({ locals, request }) => {
	console.log(locals.node);
	if (!locals.node) {
		return new Response('Node not found', { status: 404 });
	}

	const direction = (await request.text()) as Direction;
	if (!direction || !Object.values(Direction).includes(direction)) {
		return new Response('Invalid direction', { status: 400 });
	}

	locals.node.toggle(direction);
	return new Response('Toggled', { status: 200 });
};
