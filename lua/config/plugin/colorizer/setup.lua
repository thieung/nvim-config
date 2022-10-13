local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  return
end

-- Default settings: https://github.com/NvChad/nvim-colorizer.lua#customization
colorizer.setup({
  filetypes = {
    "*", -- Highlight all files, but customize some others.
    html = { mode = "foreground" },
    "!vim", -- Exclude vim from highlighting.
  },
  buftypes = {
    "*",
    -- exclude prompt and popup buftypes from highlight
    "!prompt",
    "!popup",
  },
  user_default_options = { mode = "background", names = false },
})
