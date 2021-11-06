fx_version 'bodacious'
game 'gta5'

description 'SSCore - A Framework built by Hayden#6789 and Jones#1913'
version '1.00'
author 'ScriptShare.net'

ui_page 'util/ui-wrapper/index.html'

shared_scripts {
	'core/import.lua',
	'languages/languages.lua',
	'config/sh_*.lua',
	'util/func/sh_*.lua',
	'util/ui-wrapper/sh_*.lua',
	'core/skin/sh_*.lua',
	'core/functions/sh_*.lua',
	'core/player/sh_*.lua',
	'core/selector/sh_*.lua',
}

server_scripts {
	'config/sv_*.lua',
	'util/func/sv_*.lua',
	'util/ui-wrapper/sv_*.lua',
	'util/discord/config.js',
	'util/discord/app.js',
	'core/skin/sv_*.lua',
	'core/functions/sv_*.lua',
	'core/player/sv_*.lua',
	'core/selector/sv_*.lua',
	'core/ui/scoreboard/sv_*.lua',
}

client_scripts {
	'config/cl_*.lua',
	'util/func/cl_*.lua',
	'util/ui-wrapper/cl_*.lua',
	'util/discord/client.lua',
	'core/ui/progress/cl_*.lua',
	'core/skin/cl_*.lua',
	'core/functions/cl_*.lua',
	'core/player/cl_*.lua',
	'core/selector/cl_*.lua',
	'core/ui/hud/cl_*.lua',
	'core/ui/scoreboard/cl_*.lua',
}

files {
	'**/f_*.js',
	'**/f_*.png',
	'**/f_*.jpg',
	'**/f_*.css',
	'**/f_*.ogg',
	'**/*.html',
}

dependencies {
	'bob74_ipl',
}