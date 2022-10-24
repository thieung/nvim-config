local status_ok, gitsigns = pcall(require, "gitsigns")
local gitrepo = vim.fn.isdirectory(".git/index")

if not status_ok or not gitrepo then
  return
end

gitsigns.setup({
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  -- trouble = true,
  -- signcolumn = false,
  -- numhl = true,
  on_attach = function(bufnr)
    require("config.plugin.gitsigns.keymap").attach(gitsigns, bufnr)
  end,
  preview_config = { border = "rounded" },
  current_line_blame_opts = { delay = vim.api.nvim_get_option("updatetime") },
  current_line_blame_formatter = " ﰖ <author>, <author_time:%Y-%m-%d> - <summary>",
})
