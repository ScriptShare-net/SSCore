fx_version 'bodacious'
game 'gta5'

description 'SSCore - A Framework built by Hayden#6789 and Jones#1913'
version '1.00'
author 'ScriptShare.net'

shared_scripts {
    'connection/sh_*.lua'
}

server_scripts {
    'core/sv_config.lua',
    'core/sv_cards.lua',
    'core/sv_main.lua',
    'connection/sv_*.lua'
}

client_scripts {
    'core/cl_*.lua',
    'connection/cl_*.lua'
}

files {
}

dependencies {
}