import { type ViteDevServer } from 'vite';

import { WebSocketServer } from 'ws';

const webSocketServer = {
	name: 'webSocketServer',
	configureServer(server: ViteDevServer) {
		if (!server.httpServer) return;

		const io = new Server(server.httpServer);

		io.on('connection', (socket) => {
			socket.emit('eventFromServer', 'Hello, World 👋');
		});
	}
};

export const configureServer = (server: ViteDevServer) => {
	const webSocketServer = new WebSocketServer({
		server: server.httpServer
	});

	webSocketServer.on('connection', (socket, request) => {
		socket.on('message', (data, isBinary) => {
			console.log(`Recieved ${data}`);
		});

		socket.send('test from server');
	});
};

export const webSocketServer = {
	name: 'webSocketServer',
	configureServer
};
