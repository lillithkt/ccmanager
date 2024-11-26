import serverConfig, { type ServerConfig } from '$lib/config';
import { json, text, type RequestHandler } from '@sveltejs/kit';

export const GET: RequestHandler = async ({ request }) => {
	const config: Partial<ServerConfig> = Object.assign({}, serverConfig);
    delete config.passwords;
    return json(config);
};
