local function getPasswordCookie()
    local type = lvn.config.get("boot.type")
    local password = lvn.config.get(type .. ".password")
    return "password=" .. password
end

local function downloadFile(url, path)
    local url = url
    if url:find("^/") then
        url = lvn.urls.httpBase .. url
    end
    local file = http.get(url)
    if not file then
        printError("Failed to download file from " .. url)  
        return false
    end
    local fileContents = file.readAll()
    file.close()
    local file = fs.open(path, "w")
    file.write(fileContents)
    file.close()
    return true
end

local function downloadFunction(url)
    local url = url
    if url:find("^/") then
        url = lvn.urls.httpBase .. url
    end
    local file = http.get(url)
    if not file then
        return false
    end
    local fileContents = file.readAll()
    file.close()
    return loadstring(fileContents)
end

local function get(url)
    local url = url
    if url:find("^/") then
        url = lvn.urls.httpBase .. url
    end
    local file = http.get(url, {
        ["Cookie"] = getPasswordCookie()
    })
    if not file then
        return false
    end
    local fileContents = file.readAll()
    file.close()
    return fileContents
end

local function post(url, data)
    local url = url
    if url:find("^/") then
        url = lvn.urls.httpBase .. url
    end
    local file, e = http.post(url, data, {
        ["Cookie"] = getPasswordCookie()
    })
    if not file then
        return false
    end
    local fileContents = file.readAll()
    file.close()
    return fileContents
end

lvn.net = {
    downloadFile = downloadFile,
    downloadFunction = downloadFunction,
    get = get,
    post = post,
}