local completion = require('/lvn/core/completion')

local nodes = textutils.unserializeJSON(lvn.net.get("/api/admin/nodes"))

local possibleNodes = {}
  
for i, node in ipairs(nodes) do
  if node.tardis then
    table.insert(possibleNodes, node.name)
    table.insert(possibleNodes, tostring(node.id))
  end
end



local methods = {}
if #possibleNodes > 0 then
  local res = lvn.net.get("/api/admin/nodes/" .. possibleNodes[1] .. "/tardis/methods")
  if res then
    methods = textutils.unserializeJSON(res)
  end
end

completion.setCompletionFunction(function()
  local ccCompletion = require("cc.shell.completion")
  
  -- nodes: array of {name: string, id: string}
  -- allow param 1 to be a node name or id
  -- add the node name and id to the possibleNodes list
  local possibleNodesChoice = { ccCompletion.choice, possibleNodes }
  local methodsChoice = { ccCompletion.choice, methods }


  return ccCompletion.build(possibleNodesChoice, methodsChoice
  )
end)

completion.setHelpText("Usage: tardis <tardisName> [method] [...args]")
completion.setHelpText("Control a tardis")

completion.setRequiredArgs(1)

local tArgs = { ... }

if not completion.check(tArgs) then
  return
end

if #tArgs < 2 then
  print("Methods: " .. table.concat(methods, ", "))
  return
end

local args = {}
for i = 3, #tArgs do
  table.insert(args, textutils.unserializeJSON(tArgs[i]))
end

local res = lvn.net.post("/api/admin/nodes/" .. tArgs[1] .. "/tardis/method", textutils.serializeJSON(
  {
    method = tArgs[2],
    args = args
  }))

if not res then
  print("Tardis Method Failed")
  return
end

local response = textutils.unserializeJSON(res)
if response.success then
  print("Success: " .. textutils.serializeJSON(response.output))
else
  print("Failed: " .. textutils.serializeJSON(response.output))
end