import type { SerializableClient } from '$lib/types/client';
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ params, locals, cookies }) => {
	const node = locals.wss.getNode(params.id);
	if (!node) {
		throw new Error('Node not found');
	}
	return {
		node: JSON.parse(JSON.stringify(node.serializable)) as SerializableClient,
		password: cookies.get('password')
	};
};
