export class SerializableClient {
	name: string;
	id: number;
	debug: boolean;

	constructor(client: SerializableClient) {
		this.name = client.name;
		this.id = client.id;
		this.debug = client.debug;
	}
}
