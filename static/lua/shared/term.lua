local termObj = {}

termObj.term = term.current()
termObj.write = function(...)
  -- loop over all chars in the string
  for i = 1, select("#", ...) do
    local s = tostring(select(i, ...))
    for j = 1, #s do
      local char = s:sub(j, j)
      termObj.term.write(char)
      local width = termObj.term.getSize()
      local w, h = termObj.term.getCursorPos()
      if w == width then
        termObj.term.setCursorPos(1, h + 1)
      end
    end
  end
  local w, h = termObj.term.getCursorPos()
  termObj.term.setCursorPos(1, h + 1)
end

return termObj