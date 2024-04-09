export enum ClientPacketType {
	Register = 'register',
	Heartbeat = 'heartbeat',
	Eval = 'eval'
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
};

export type ClientPacket = {
	[key in ClientPacketType]: {
		type: key;
		data: ClientPacketData[key];
	};
};
