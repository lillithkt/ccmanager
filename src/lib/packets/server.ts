import type { ClientType } from '$lib/types';

export enum ServerPacketType {
	Register = 'register',
	Heartbeat = 'heartbeat',
	Eval = 'eval'
}

export type ServerPacketData = {
	[ServerPacketType.Register]: {
		type: ClientType.Node;
		name: string;
		id: number;
		password: string;
		debug?: boolean;
	};
	[ServerPacketType.Heartbeat]: number;
	[ServerPacketType.Eval]: {
		nonce: number;
		success: boolean;
		// eslint-disable-next-line @typescript-eslint/no-explicit-any
		output: any;
	};
};

export type ServerPacket = {
	[key in ServerPacketType]: {
		type: key;
		data: ServerPacketData[key];
	};
};
