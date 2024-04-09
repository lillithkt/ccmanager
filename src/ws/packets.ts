import type { ClientType } from '$lib/types';

export enum PacketType {
	Register = 0
}

export type PacketDataToServer = {
	[PacketType.Register]: {
		type: ClientType;
		nodeData?: {
			name: string;
			id: string;
		};
	};
};

export type PacketDataToClient = {
	[PacketType.Register]: {
		success: boolean;
	};
};
