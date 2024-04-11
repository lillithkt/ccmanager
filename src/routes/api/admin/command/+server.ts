import { json, text, type RequestHandler } from '@sveltejs/kit';

export const POST: RequestHandler = async ({ request, locals }) => {
	const command = await request.text();

	const node = Array.from(locals.wss.nodes.values()).find((i) => i.command);

	if (!node) {
		return text('Node not found', { status: 404 });
	}

	const res = await node.runCommand(command);
	return json({
		...res,
		node: node.serializable
	});
};
