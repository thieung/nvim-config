local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn

-- ensure that packer is installed
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim" -- packer is optional
if fn.empty(fn.glob(install_path)) > 0 then
  execute(
    "!git clone https://github.com/wbthomason/packer.nvim " .. install_path
  )
  execute("packadd packer.nvim")
end

vim.cmd("packadd packer.nvim")

local plugins = {
  require("config.plugin.plenary.packer_spec"),
  require("config.plugin.colorbuddy.packer_spec"),
  require("config.plugin.schemastore.packer_spec"),
  require("config.plugin.treesitter.packer_spec"),
  require("config.plugin.treesitter-context.packer_spec"),
  require("config.plugin.devicons.packer_spec"),
  require("config.plugin.telescope.packer_spec"),
  require("config.plugin.lspconfig.packer_spec"),
  require("config.plugin.null-ls.packer_spec"),
  require("config.plugin.neo-tree.packer_spec"),
  require("config.plugin.navic.packer_spec"),
  require("config.plugin.notify.packer_spec"),
  require("config.plugin.fidget.packer_spec"),
  require("config.plugin.cmp.packer_spec"),
  require("config.plugin.dressing.packer_spec"),
  require("config.plugin.gitsigns.packer_spec"),
  require("config.plugin.typescript.packer_spec"),
  require("config.plugin.incline.packer_spec"),
  require("config.plugin.colorizer.packer_spec"),
  require("config.plugin.trouble.packer_spec"),
  require("config.plugin.terminal.packer_spec"),
  require("config.plugin.mini.packer_spec"),
  require("config.plugin.smart-splits.packer_spec"),
  require("config.plugin.git-conflict.packer_spec"),
  --require("config.plugin.heirline.packer_spec"),
}

local packer = require("packer")
local setup = require("config.plugin.packer.setup")
packer.init(setup.init)
packer.startup(setup.use(plugins))

local utils = require("utils")
utils.Augroup("OnPackerEvent", function(autocmd)
  autocmd("User", "PackerCompileDone", function()
    vim.notify(
      (" Compiled at %s"):format(os.date()),
      vim.log.levels.INFO,
      { title = "packer.nvim" }
    )
  end)
end)
