#!/usr/bin/env sh

nvim --headless \
  -c 'autocmd User PackerComplete quitall' \
  -c 'lua require("config.plugin.packer")' \
  -c 'PackerSync'
