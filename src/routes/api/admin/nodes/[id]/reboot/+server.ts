import { text, type RequestHandler } from '@sveltejs/kit';

export const POST: RequestHandler = async ({ locals }) => {
	if (!locals.node) {
		return text('Node not found', { status: 404 });
	}

	locals.node.reboot();

	return text('Rebooting node...');
};
