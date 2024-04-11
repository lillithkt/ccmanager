import { text, type RequestHandler } from '@sveltejs/kit';

export const POST: RequestHandler = async ({ request, locals, params }) => {
	const message = await request.text();
	console.log(message);

	const node = Array.from(locals.wss.nodes.values()).find((i) => i.command);

	if (!node) {
		return text('Node not found');
	}

	let msg = message;

	if (locals.node) {
		msg = `[${locals.node.name} (${locals.node.id})] ${msg}`;
	} else {
		msg = `[${params.id}] ${msg}`;
	}

	node.runCommand(`tellraw @a {"text":"${msg}"}`);

	return text('OK');
};
