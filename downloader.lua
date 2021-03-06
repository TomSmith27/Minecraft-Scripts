local tArgs = {...}
local user = tArgs[1] or "TomSmith27"
local repository = tArgs[2] or "Minecraft-Scripts"
local gitPath = tArgs[3] or "/"--"/folder/folder/file" or "/" for root
local branch = tArgs[5] or nil
local URL = "https://api.github.com/repos/" .. user .. "/" .. repository .. "/contents" .. gitPath .. (branch and "?ref=" or "") .. (branch or "")
local removeLuaExtention = tArgs[4] or true

fs.delete("Minecraft-Scripts")
function getFileDownloadURLs(url, gatheredFiles, gatheredDirectories)
    assert(url, "url invalid")
    print("Downloading " .. url)
    local handle = assert(http.get(url), "Getting " .. url .. " failed")
    local json = assert(handle.readAll(), "Reading failed for url " .. url)
    json = json:gsub("%s*\n%s*", "") --removes white space around '\n' and '\n'
    json = json:gsub("\"([^\"]*)\"%s*:%s*", "%1 = ") --turns '"hi": ' into 'hi = '
    json = json:sub(2, #json - 1) --removes brackets around the almostJSON
    json = "{" .. json .. "}" --adds curly brackets
    local jsonTable = assert(textutils.unserialize(json), "Failed to unserialize:\n" .. json)
    local files = gatheredFiles or {}
    local directories = gatheredDirectories or {}
    for k, v in ipairs(jsonTable) do
        if v.type == "file" then
            files[#files + 1] = {url = v.download_url, path = v.path}
        elseif v.type == "dir" then
            directories[#directories + 1] = v.url
        end
    end
    local recursiveURL = directories[1]
    if not recursiveURL then
        return files
    end
    if recursiveURL then
        table.remove(directories, 1)
        return getFileDownloadURLs(recursiveURL, files, directories)
    end
end

for k, v in ipairs(getFileDownloadURLs(URL)) do
    if (v.path:sub(#v.path - 3) == ".lua") and removeLuaExtention then
        v.path = v.path:sub(1, #v.path - 4)
    end
    print("Saving " .. v.url .. " as " .. repository .. "/" .. v.path)
    local writeFile = fs.open(repository .. "/" .. v.path, "w")
    local webHandle = assert(http.get(v.url), "Getting " .. v.url .. " failed")
    local webContents = assert(webHandle.readAll(), "Reading " .. v.url .. " failed")
    writeFile.write(webContents)
    writeFile.close()
end

print(URL)