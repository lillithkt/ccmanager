// See https://kit.svelte.dev/docs/types#app

import type { Node } from '$lib/server/client/node';
import type { ExtendedWebSocketServer } from '$lib/server/websocket/server';

// for information about these interfaces
declare global {
	namespace App {
		// interface Error {}
		interface Locals {
			wss: ExtendedWebSocketServer;
			node?: Node;
		}
		// interface PageData {}
		// interface PageState {}
		// interface Platform {}
	}
}

export {};
