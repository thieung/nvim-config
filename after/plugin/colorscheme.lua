local group = vim.api.nvim_create_augroup("UseColorScheme", {})
vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  callback = function()
    local default = "onedark"
    local colorschemes = {
      ["doom-one"] = "doom-one",
      kanagawa = "kanagawa",
      material = "material",
      ["rose-pine"] = "rose-pine",
      tokyonight = "tokyonight",
      onedark = "onedark",
    }

    local colorscheme = colorschemes[os.getenv("NVIM_COLORSCHEME")] or default
    vim.api.nvim_exec_autocmds("ColorSchemePre", {})
    vim.cmd.packadd(("colorscheme/%s"):format(colorscheme))
    require(("config.plugin.colorscheme.%s.setup"):format(colorscheme))
    vim.api.nvim_exec_autocmds("ColorScheme", { pattern = colorscheme })
  end,
})
