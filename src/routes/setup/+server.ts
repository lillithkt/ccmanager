import type { ClientBootConfig } from '$lib/config';
import serverConfig from '$lib/config';
import type { RequestHandler } from '@sveltejs/kit';

export const GET: RequestHandler = async ({ request }) => {
	if (request.headers.get('user-agent')?.includes('computercraft')) {
		const config: Omit<ClientBootConfig, 'type'> = {
			host: serverConfig.connectHost,
			port: serverConfig.connectPort,
			ssl: serverConfig.ssl
		};

		return new Response(`

	function setup() 
		local config = textutils.unserializeJSON('${JSON.stringify(config)}')

		io.write("Is this a node or an admin client? (node/admin): ")
		config.type = io.read("*l")

		if config.type == "node" or config.type == "admin" then
			
		else
			print("Invalid client type")
			setup()
			return
		end

		if not fs.isDir("/lvn") then
			fs.makeDir("/lvn")
		end

		if not fs.isDir("/lvn/config") then
			fs.makeDir("/lvn/config")
		end

		if not fs.isDir("/lvn/core") then
			fs.makeDir("/lvn/core")
		end

		local configFile = fs.open("/lvn/config/boot.json", "w")

		configFile.writeLine(textutils.serializeJSON(config))

		configFile.close()

		local luaBase = "http${config.ssl ? 's' : ''}://${config.host}:${config.port}/lua"

		function downloadFile(url, path)
    	local file = http.get(luaBase .. url)
    	if not file then
    	    return false
    	end
    	local fileContents = file.readAll()
    	file.close()
    	local file = fs.open(path, "w")
    	file.write(fileContents)
    	file.close()
    	return true
		end

		downloadFile("/boot.lua", "/startup/boot.lua")

		downloadFile("/core/bootConfig.lua", "/lvn/core/bootConfig.lua")

		downloadFile("/core/download.lua", "/lvn/core/download.lua")

		downloadFile("/core/urls.lua", "/lvn/core/urls.lua")


	end

	setup()
	`);
	}
	return new Response(
		`wget run http${serverConfig.ssl ? 's' : ''}://${serverConfig.connectHost}:${serverConfig.connectPort}/setup`
	);
};
