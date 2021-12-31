fx_version 'bodacious'
game 'gta5'

description 'SSCore - A Framework built by Jones#1913 with help from Hayden#6789'
version '1.00'
author 'ScriptShare.net'

lua54 'yes'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'core/sv_init.lua',
    'core/sh_config.lua',
    'core/sv_functions.lua',
	'groups/sv_init.lua',
    'bans/sv_init.lua',
    'users/sv_init.lua',
    'users/sv_class.lua',
    'connection/sv_config.lua',
    'connection/sv_cards.lua',
    'connection/sv_init.lua',
    'characters/sv_init.lua',
    'characters/sv_class.lua',
    'vehicles/sv_init.lua',
    'vehicles/sv_class.lua',
    'gangs/sv_init.lua',
    'gangs/sv_class.lua',
    'businesses/sv_init.lua',
    'businesses/sv_class.lua',
	'modules/skin/sv_init.lua',
	'modules/character_selector/sv_config.lua',
	'modules/character_selector/sv_init.lua',
}

client_scripts {
    '@menuv/menuv.lua',
	'core/cl_init.lua',
	'core/sh_config.lua',
	'core/cl_functions.lua',
	'users/cl_init.lua',
	'modules/skin/cl_init.lua',
	'modules/character_selector/cl_config.lua',
	'modules/character_selector/cl_init.lua',
}

files {
	'modules/character_selector/index.html',
	'modules/character_selector/f_script.js',
}

dependencies {
	'oxmysql',
	'ui-wrapper',
	'bob74_ipl',
	'menuv',
	'fivem-appearance',
}