fx_version 'cerulean'
game 'gta5'

author 'Solos'
description 'solos-jointroll'
version '1.0.0'

client_script {
    'client.lua',
}

server_script {
    'server.lua',
}

shared_scripts {
    'shared/config.lua',
    'shared/effects.lua',
    '@ox_lib/init.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
}

escrow_ignore {
    'shared/*.lua',
    'client.lua',
    'server.lua',
	'html/index.html',
	'html/style.css',
	'html/script.js',
}

lua54 'yes'
dependency '/assetpacks'