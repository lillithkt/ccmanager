// See https://kit.svelte.dev/docs/types#app

import type { ExtendedWebSocketServer } from '$lib/server/websocket/server';

// for information about these interfaces
declare global {
	namespace App {
		// interface Error {}
		interface Locals {
			wss: ExtendedWebSocketServer;
		}
		// interface PageData {}
		// interface PageState {}
		// interface Platform {}
	}
}

export {};
