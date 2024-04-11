import type { SerializableClient } from '$lib/types/client';
import type { Direction, TurtleDirection } from '$lib/types/direction';
import type { ServerPacket, ServerPacketType } from './server';

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
	Refuel = 'refuel',
	SetDebug = 'setDebug',
	AdminNodePacket = 'adminNodePacket'
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
	[ClientPacketType.SetDebug]: boolean;
	[ClientPacketType.AdminNodePacket]: {
		node: SerializableClient;
		toServer: boolean;
		packet: ServerPacket[ServerPacketType] | ClientPacket[ClientPacketType];
	};
};

export type ClientPacket = {
	[key in ClientPacketType]: {
		type: key;
		data: ClientPacketData[key];
	};
};
