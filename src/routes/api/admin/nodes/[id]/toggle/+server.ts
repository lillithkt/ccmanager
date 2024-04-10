import { Direction } from '$lib/types/direction';
import { text, type RequestHandler } from '@sveltejs/kit';

export const POST: RequestHandler = async ({ locals, request }) => {
	console.log(locals.node);
	if (!locals.node) {
		return text('Node not found', { status: 404 });
	}

	const direction = (await request.text()) as Direction;
	if (!direction || !Object.values(Direction).includes(direction)) {
		return text('Invalid direction', { status: 400 });
	}

	locals.node.toggle(direction);
	return text('Toggled');
};
