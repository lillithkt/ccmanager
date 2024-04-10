import type { Direction, TurtleDirection } from '$lib/types/direction';

export enum ClientPacketType {
	Register = 'register',
	Heartbeat = 'heartbeat',
	Eval = 'eval',
	Toggle = 'toggle',
	TurnOn = 'turnOn',
	TurnOff = 'turnOff',
	Update = 'update',
	Move = 'move',
	Dig = 'dig',
	Refuel = 'refuel'
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
	[ClientPacketType.Update]: Record<string, never>;
	[ClientPacketType.Move]: TurtleDirection;
	[ClientPacketType.Dig]: TurtleDirection;
	[ClientPacketType.Refuel]: Record<string, never>;
};

export type ClientPacket = {
	[key in ClientPacketType]: {
		type: key;
		data: ClientPacketData[key];
	};
};
