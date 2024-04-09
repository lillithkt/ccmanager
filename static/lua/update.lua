bootConfig = require('/lvn/core/bootConfig')
download = require('/lvn/core/download')

print('Downloading core files...')

if fs.exists('/lvn/core') then
  fs.delete('/lvn/core')
end

print('Downloading core files...')
print('Downloading boot.lua...')
download.downloadFile('/lua/boot.lua', '/startup/boot.lua')

print('Downloading bootConfig.lua...')
download.downloadFile('/lua/core/bootConfig.lua', '/lvn/core/bootConfig.lua')

print('Downloading download.lua...')
download.downloadFile('/lua/core/download.lua', '/lvn/core/download.lua')

print('Downloading urls.lua...')
download.downloadFile('/lua/core/urls.lua', '/lvn/core/urls.lua')