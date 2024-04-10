import type { ExtendedWebSocketServer } from './server';

// eslint-disable-next-line @typescript-eslint/no-explicit-any
const wss = (globalThis as any).wss as ExtendedWebSocketServer;

export default wss;
