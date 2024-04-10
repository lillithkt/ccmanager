import { ClientPacketType } from '$lib/packets/client';
import type { Direction, TurtleDirection } from '$lib/types/direction';
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

	move(direction: TurtleDirection) {
		this.send(ClientPacketType.Move, direction);
	}

	dig(direction: TurtleDirection) {
		this.send(ClientPacketType.Dig, direction);
	}

	refuel() {
		this.send(ClientPacketType.Refuel, {});
	}
}
