import { text, type RequestHandler } from '@sveltejs/kit';

export const GET: RequestHandler = () => text('Hello, world!');
