local function getPasswordCookie()
    local type = lvn.config.get("boot.type")
    local password = lvn.config.get(type .. ".password")
    return "password=" .. password
end

local function downloadFile(url, path)
    local fileContents = lvn.net.get(url, true, true)
    local file = fs.open(path, "w")
    file.write(fileContents)
    file.close()
    return true
end

local function downloadFunction(url)
    local fileContents = lvn.net.get(url, true, true)
    return loadstring(fileContents)
end

local function get(url, nocreds, nolog)
    local url = url
    if url:find("^/") then
        url = lvn.urls.httpBase .. url
    end
    if lvn.config.get("debug") and not nolog then
        print("GET: " .. url)
    end
    local file, e = http.get(url, not nocreds and {
        ["Cookie"] = getPasswordCookie()
    } or {})
    if not file then
        if nolog then
            print("GET: " .. url)
        end
        printError("GET failed: ", e)
        lvn.chat("GET failed: " .. e)
        return false
    end
    local fileContents = file.readAll()
    file.close()
    if lvn.config.get("debug") and not nolog then
        print("GET success: ", fileContents, url)
        print(getPasswordCookie())
    end
    return fileContents
end

local function post(url, data)
    local url = url
    if url:find("^/") then
        url = lvn.urls.httpBase .. url
    end
    if lvn.config.get("debug") then
        print("POST: " .. url)
    end
    local file, e = http.post(url, data, {
        ["Cookie"] = getPasswordCookie()
    })
    if not file then
        printError("POST failed: ", e)
        return false
    end
    local fileContents = file.readAll()
    file.close()
    if lvn.config.get("debug") then
        print("POST success: ", fileContents, url)
    end
    return fileContents
end

lvn.net = {
    downloadFile = downloadFile,
    downloadFunction = downloadFunction,
    get = get,
    post = post,
}