local status_ok, gitsigns = pcall(require, "gitsigns")
local gitrepo = vim.fn.isdirectory(".git/index")

if not status_ok or not gitrepo then
  return
end

local sign = require("const.LINE_CHAR")

gitsigns.setup({
  signs = {
    add = { text = sign.HALF.right },
    change = { text = sign.HALF.right },
    delete = { text = sign.HALF.right },
    topdelete = { text = sign.HALF.right },
    changedelete = { text = sign.HALF.right },
  },
  trouble = true,
  signcolumn = false,
  numhl = true,
  on_attach = function(bufnr)
    require("config.plugin.gitsigns.keymap").attach(gitsigns, bufnr)
  end,
  preview_config = { border = "rounded" },
  current_line_blame_opts = { delay = vim.api.nvim_get_option("updatetime") },
  current_line_blame_formatter = " ﰖ <author>, <author_time:%Y-%m-%d> - <summary>",
})
