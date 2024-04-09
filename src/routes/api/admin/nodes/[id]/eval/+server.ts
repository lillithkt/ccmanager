import type { RequestHandler } from '@sveltejs/kit';

export const POST: RequestHandler = async ({ request, params, locals }) => {
	const code = await request.text();
	const node = locals.wss.nodes.get(Number(params.id));
	if (!node) {
		return new Response('Node not found', { status: 404 });
	}

	try {
		const res = await node.eval(code);
		return new Response(JSON.stringify(res), { status: 200 });
		// eslint-disable-next-line @typescript-eslint/no-explicit-any
	} catch (e: any) {
		return new Response(e.toString(), { status: 500 });
	}
};
