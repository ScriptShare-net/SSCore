fx_version 'cerulean'
game 'gta5'

description 'SSCore - A Framework built by Hayden#6789 and Jones#1913'
version '1.00'
author 'ScriptShare.net'

shared_scripts {
	'languages/languages.lua',
	'**/sh_*.lua',
	'**/**/sh_*.lua',
	'**/sh_*.js',
	'**/**/sh_*.js',
}

server_scripts {
	'**/sv_*.lua',
	'**/**/sv_*.lua',
	'**/sv_*.js',
	'**/**/sv_*.js',
}

client_scripts {
	'**/cl_*.lua',
	'**/**/cl_*.lua',
	'**/cl_*.js',
	'**/**/cl_*.js',

}

files {
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