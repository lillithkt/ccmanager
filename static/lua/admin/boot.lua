lvn.net.downloadFile('/lua/admin/toggle.lua', '/run/toggle.lua')
shell.setAlias('toggle', '/run/toggle.lua')
shell.run('/run/toggle.lua completion')

lvn.net.downloadFile('/lua/admin/eval.lua', '/run/eval.lua')
shell.setAlias('eval', '/run/eval.lua')
shell.run('/run/eval.lua completion')