import { ClientPacketType } from '$lib/packets/client';
import type { Direction } from '$lib/types/direction';
import { Client } from './';

export class Node extends Client {
	toggle(direction: Direction) {
		this.send(ClientPacketType.Toggle, direction);
	}

	turnOn(direction: Direction) {
		this.send(ClientPacketType.TurnOn, direction);
	}

	turnOff(direction: Direction) {
		this.send(ClientPacketType.TurnOff, direction);
	}
}
