local function get(key, default)
  return settings.get("lvn." .. key, default)
end

local function set(key, value)
  settings.set("lvn." .. key, value)
  settings.save()
end

local function exists(key)
  return settings.get("lvn." .. key) ~= nil
end

lvn.config = {
  get = get,
  set = set,
  exists = exists
}