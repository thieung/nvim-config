local status_ok, hl_colors = pcall(require, "nvim-highlight-colors")
if not status_ok then
  return
end

hl_colors.setup({
  render = "background",
  enable_tailwind = true,
})
