import { text, type RequestHandler } from '@sveltejs/kit';

export const POST: RequestHandler = async ({ locals, request }) => {
	if (!locals.node) {
		return text('Node not found', { status: 404 });
	}

	locals.node.debug = (await request.text()) === 'true';

	return text(locals.node.debug.toString());
};
