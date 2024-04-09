local download = {}

urls = require('/lvn/core/urls')

function download.downloadFile(url, path)
    local url = url
    if url:find("^/") then
        url = urls.httpBase .. url
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

function download.downloadFunction(url)
    local url = url
    if url:find("^/") then
        url = urls.httpBase .. url
    end
    local file = http.get(url)
    if not file then
        return false
    end
    local fileContents = file.readAll()
    file.close()
    return loadstring(fileContents)
end 

return download