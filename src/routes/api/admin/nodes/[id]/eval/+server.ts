import type { RequestHandler } from '@sveltejs/kit';

export const POST: RequestHandler = async ({ request, locals }) => {
	const code = await request.text();
	if (!locals.node) {
		return new Response('Node not found', { status: 404 });
	}

	try {
		const res = await locals.node.eval(code);
		return new Response(JSON.stringify(res), { status: 200 });
		// eslint-disable-next-line @typescript-eslint/no-explicit-any
	} catch (e: any) {
		return new Response(e.toString(), { status: 500 });
	}
};
