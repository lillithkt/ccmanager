import type { AdminClientConfig } from '$lib/config';

const adminConfig: AdminClientConfig = {
  

const file = `
local config = {
  host = "${config.host}",
  port = ${config.port},
  ssl = ${config.ssl},
  password = "${config.password}",
  type = ${config.type}
}

local configFile = fs.open("/lvn/config.json", "w")
configFile.writeLine(textutils.serializeJSON(config))
configFile.close()

shell.run("wget ${config.HTTP_URL}/lua/boot.lua /startup/boot.lua")

os.reboot()
`;

const adminFile = `

local config = {
  BOOT = "admin",
  PORT = ${config.PORT},
  WS_URL = "${config.WEBSOCKET_URL}/admin",
  HTTP_URL = "${config.HTTP_URL}"
}
local configFile = fs.open("/config.json", "w")
configFile.writeLine(textutils.serializeJSON(config))
configFile.close()

shell.run("wget ${config.HTTP_URL}/lua/boot.lua /startup/boot.lua")

os.reboot()
`;

router.get('/setup-node', (req, res) => {
	res.send(nodeFile);
});

router.get('/setup-admin', (req, res) => {
	res.send(adminFile);
});
