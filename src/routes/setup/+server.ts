import serverConfig from '$lib/config';
import { text, type RequestHandler } from '@sveltejs/kit';

export const GET: RequestHandler = async ({ request }) => {
	if (request.headers.get('user-agent')?.includes('computercraft')) {
		return text(`
	
		function setConfig(name, val)
			settings.set("lvn." .. name, val)
		end

		settings.set("motd.enable", false)
		settings.save()


		function setup() 
			

			io.write("Is this a node or an admin client? (node/admin): ")
			local type = io.read("*l")

			if type == "node" or type == "admin" then
				setConfig("boot.type", type)
			else
				print("Invalid client type")
				setup()
				return
			end

			io.write("What would you like this to be named? ")
			local name = io.read("*l")

			os.setComputerLabel(name)

			setConfig("boot.ssl", ${serverConfig.ssl ? 'true' : 'false'})
			setConfig("boot.host", "${serverConfig.connectHost}")
			setConfig("boot.port", ${serverConfig.connectPort})

			settings.save()

			if not fs.isDir("/lvn") then
				fs.makeDir("/lvn")
			end

			if not fs.isDir("/lvn/core") then
				fs.makeDir("/lvn/core")
			end


			local luaBase = "http${serverConfig.ssl ? 's' : ''}://${serverConfig.connectHost}:${serverConfig.connectPort}/lua"

			function downloadFile(url, path)
				local file = http.get(luaBase .. url)
				if not file then
					print("Failed to download " .. url)
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

			downloadFile("/core/config.lua", "/lvn/core/config.lua")

			downloadFile("/core/net.lua", "/lvn/core/net.lua")

			downloadFile("/core/urls.lua", "/lvn/core/urls.lua")

			downloadFile("/core/utils.lua", "/lvn/core/utils.lua")

			downloadFile("/core/chat.lua", "/lvn/core/chat.lua")

			downloadFile("/core/lvn.lua", "/lvn/core/lvn.lua")

			print("Setup complete")

			os.reboot()
		end

		setup()
	`);
	}
	return text(
		`wget run http${serverConfig.ssl ? 's' : ''}://${serverConfig.connectHost}:${serverConfig.connectPort}/setup`
	);
};
