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
    local file = http.get(url)
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
    print(url)
    print(data)
    local file = http.post(url, data)
    print(file)
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