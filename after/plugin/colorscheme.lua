local group = vim.api.nvim_create_augroup("UseColorScheme", {})
vim.api.nvim_create_autocmd("UIEnter", {
  group = group,
  callback = function()
    local default = "onedark"
    local colorschemes = {
      onedark = "onedark",
      rxyhn = "rxyhn",
    }

    local colorscheme = colorschemes[os.getenv("NVIM_COLORSCHEME")] or default

    vim.api.nvim_exec_autocmds("ColorSchemePre", {})
    require("colors").setup(colorscheme)
    vim.api.nvim_exec_autocmds("ColorScheme", { pattern = colorscheme })
  end,
})
