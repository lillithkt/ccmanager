import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async (request) => {
	const node = request.locals.wss.nodes.get(Number(request.params.id));
	if (!node) {
		throw new Error('Node not found');
	}

	return {
		node: JSON.parse(JSON.stringify(node.serializable))
	};
};
