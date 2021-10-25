fx_version 'bodacious'
game 'gta5'

description 'SSCore - A Framework built by Hayden#6789 and Jones#1913'
version '1.00'
author 'ScriptShare.net'

ui_page 'util/ui-wrapper/index.html'

shared_scripts {
	'core/import.lua',
	'util/**/sh_*.lua',
	'languages/languages.lua',
	'**/sh_*.lua',
	'**/**/sh_*.lua',
	'**/sh_*.js',
	'**/**/sh_*.js',
}

server_scripts {
	'util/**/sv_*.lua',
	'**/sv_*.lua',
	'**/**/sv_*.lua',
	'**/sv_*.js',
	'**/**/sv_*.js',
}

client_scripts {
	'util/**/cl_*.lua',
	'core/skin/cl_skin.lua',
	'**/cl_*.lua',
	'**/**/cl_*.lua',
	'**/cl_*.js',
	'**/**/cl_*.js',

}

files {
	'util/**/f_*.js',
	'util/**/f_*.png',
	'util/**/f_*.jpg',
	'util/**/f_*.css',
	'util/**/f_*.ogg',
	'util/**/f_*.html',
	'**/f_*.png',
	'**/**/f_*.png',
	'**/**/**/f_*.png',
	'**/f_*.jpg',
	'**/**/f_*.jpg',
	'**/**/**/f_*.jpg',
	'**/f_*.css',
	'**/**/f_*.css',
	'**/**/**/f_*.css',
	'**/f_*.js',
	'**/**/f_*.js',
	'**/**/**/f_*.js',
	'**/f_*.ogg',
	'**/**/f_*.ogg',
	'**/**/**/f_*.ogg',
	'**/*.html',
	'**/**/*.html',
	'**/**/**/*.html',
}

dependencies {
	'bob74_ipl',
}