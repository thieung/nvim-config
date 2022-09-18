#!/usr/bin/env sh

nvim --headless \
	-c 'autocmd User PackerCompileDone quitall' \
	-c 'lua require("config.plugin.packer")' \
	-c 'PackerCompile'
