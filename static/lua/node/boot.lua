lvn.net.downloadFile('/lua/node/main.lua', '/run/main.lua')

lvn.net.downloadFile('/lua/node/ws.lua', '/run/ws.lua')

lvn.net.downloadFile('/lua/shared/ws.lua', '/run/sharedWs.lua')
lvn.net.downloadFile('/lua/shared/wsLoop.lua', '/run/wsLoop.lua')

if turtle ~= nil then

  lvn.config.define("turtle.defaultMode", {
    description = "The default mode to run",
    type = "string",
    default = "idle"
  })
  lvn.config.define("defaultModeArgs", {
    description = "The default mode arguments",
    type = "table",
    default = "{}"
  })

  fs.makeDir("/run/turtle")
  fs.makeDir("/run/turtle/modes")
  lvn.net.downloadFile('/lua/turtle/main.lua', '/run/turtle/main.lua')
  lvn.net.downloadFile('/lua/turtle/ws.lua', '/run/turtle/ws.lua')
  lvn.net.downloadFile('/lua/turtle/pos.lua', '/run/turtle/pos.lua')
  lvn.net.downloadFile('/lua/turtle/modes/idle.lua', '/run/turtle/modes/idle.lua')
  lvn.net.downloadFile('/lua/turtle/modes/spin.lua', '/run/turtle/modes/spin.lua')
  lvn.net.downloadFile('/lua/turtle/modes/goto.lua', '/run/turtle/modes/goto.lua')
  lvn.net.downloadFile('/lua/turtle/modes/mine.lua', '/run/turtle/modes/mine.lua')
end


lvn.config.define("sorter", {
  description = "Specify this node as a sorter node",
  type = boolean,
  default = false
})
if lvn.config.get("sorter") then
  fs.makeDir("/run/sorter")
  -- if not fs.exists('/lvn/sorter') then
  --   fs.makeDir('/lvn/sorter')
    lvn.net.downloadFile('/lua/sorter/defaultFilters.lua', '/lvn/sorter/filters.lua')
  -- end
  lvn.net.downloadFile('/lua/sorter/filters.lua', '/run/sorter/filters.lua')
  lvn.net.downloadFile('/lua/sorter/main.lua', '/run/sorter/main.lua')

  os.loadAPI('/run/sorter/filters.lua')
  os.loadAPI('/lvn/sorter/filters.lua')
end

os.loadAPI('/run/sharedWs.lua')

lvn.config.define("node.password", {
  description = "The node's password",
  type = "string",
})

local success = pcall(shell.run, '/run/main.lua')

if not success then
  lvn.chat.send('Failed to run main.lua')

  sleep(5)

  os.reboot()
end