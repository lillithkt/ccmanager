

local numUpdated = lvn.net.post("/api/admin/nodes/update", "")

if not numUpdated then
  print("Failed to update")
  return
end

print("Updated " .. numUpdated .. " nodes")