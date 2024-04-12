local input = peripheral.wrap("top")
local sides = {
  "bottom",
  "top",
  "left",
  "right",
  "front",
  "back"
}

while true do
  for slot, item in pairs(input.list()) do
    if item then

      local item = input.getItemDetail(slot, true)

      local moved = false

      for _, side in ipairs(sides) do
        if lvn.sorter.filters[side](item) then
          print(item.name .. " >> " .. side)
          input.pushItems(side, slot)
          moved = true
          break
        end
      end

      if not moved then
        print(item.name .. " >> default")
        input.pushItems(lvn.sorter.default, slot)
      end
    end
  end
  sleep(0.1)
end