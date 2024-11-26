import { existsSync, readFileSync } from 'fs';
import { ClientType } from './types';

export interface ServerConfig {
	connectPort: number;
	connectHost: string;
	ssl: boolean;

	passwords: {
		admin: string;
		node: string;
	};
	waypointMode: 'xaero' | 'journey'
}

export interface ClientBootConfig {
	host: string;
	port: number;
	ssl: boolean;
	type: ClientType;
	customBootUrl?: string;
}

export interface BaseClientConfig {
	password: string;
	id: number;
}

export interface AdminClientConfig extends BaseClientConfig {}

export interface NodeClientConfig extends BaseClientConfig {
	name: string;
}

const defaultConfig: ServerConfig = {
	connectPort: 8081,
	connectHost: 'localhost',
	ssl: false,

	passwords: {
		admin: 'admin',
		node: 'node'
	},
	waypointMode: 'journey'
};

const serverConfig: ServerConfig = existsSync('config.json')
	? JSON.parse(readFileSync('config.json', 'utf8'))
	: defaultConfig;

export default serverConfig;
