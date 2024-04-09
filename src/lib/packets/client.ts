import type { Direction } from '$lib/types/direction';

export enum ClientPacketType {
	Register = 'register',
	Heartbeat = 'heartbeat',
	Eval = 'eval',
	Toggle = 'toggle',
	TurnOn = 'turnOn',
	TurnOff = 'turnOff'
}

export type ClientPacketData = {
	[ClientPacketType.Register]: {
		success: boolean;
		message?: string;
	};
	[ClientPacketType.Heartbeat]: number;
	[ClientPacketType.Eval]: {
		nonce: number;
		code: string;
	};
	[ClientPacketType.Toggle]: Direction;
	[ClientPacketType.TurnOn]: Direction;
	[ClientPacketType.TurnOff]: Direction;
};

export type ClientPacket = {
	[key in ClientPacketType]: {
		type: key;
		data: ClientPacketData[key];
	};
};
