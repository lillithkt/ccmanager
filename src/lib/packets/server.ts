import type { ClientType } from '$lib/types';
import type { TurtleDirection } from '$lib/types/direction';

export enum ServerPacketType {
	Register = 'register',
	Heartbeat = 'heartbeat',
	Eval = 'eval',

	// Admin ones

	Move = 'move',
	Dig = 'dig',
	Refuel = 'refuel'
}

export type ServerPacketData = {
	[ServerPacketType.Register]: {
		type: ClientType;
		name: string;
		id: number;
		password: string;
		debug?: boolean;
		turtle: boolean;
	};
	[ServerPacketType.Heartbeat]: number;
	[ServerPacketType.Eval]: {
		nonce: number;
		success: boolean;
		// eslint-disable-next-line @typescript-eslint/no-explicit-any
		output: any;
	};

	// Admin ones

	[ServerPacketType.Move]: {
		id: number;
		direction: TurtleDirection;
	};

	[ServerPacketType.Dig]: {
		id: number;
		direction: TurtleDirection;
	};
	[ServerPacketType.Refuel]: number;
};

export type ServerPacket = {
	[key in ServerPacketType]: {
		type: key;
		data: ServerPacketData[key];
	};
};
