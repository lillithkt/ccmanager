import type { RequestHandler } from '@sveltejs/kit';

export const GET: RequestHandler = async ({ locals }) => {
	return new Response(
		JSON.stringify(Array.from(locals.wss.nodes.values()).map((i) => i.serializable)),
		{ status: 200 }
	);
};
