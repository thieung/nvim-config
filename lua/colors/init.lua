local M = {}

function M.setup(theme)
  local colorbuddy_ok, _ = pcall(require, "colorbuddy")
  if not colorbuddy_ok then
    return
  end

  local fn = vim.fn

  if fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  -- clear highlights of bufferline (cuz of dynamic devicons hl group on the buffer)
  local highlights_raw =
    vim.split(vim.api.nvim_exec("filter BufferLine hi", true), "\n")
  local highlight_groups = {}

  for _, raw_hi in ipairs(highlights_raw) do
    table.insert(highlight_groups, string.match(raw_hi, "BufferLine%a+"))
  end

  for _, highlight in ipairs(highlight_groups) do
    vim.cmd([[hi clear ]] .. highlight)
  end

  require("utils").reload_modules("colors.highlights")

  local Color = require("colors.utils").Color
  local palette = require("colors.themes." .. theme)

  -- init base colors for theme
  Color.new("base00", palette.base00)
  Color.new("base01", palette.base01)
  Color.new("base02", palette.base02)
  Color.new("base03", palette.base03)
  Color.new("base04", palette.base04)
  Color.new("base05", palette.base05)
  Color.new("base06", palette.base06)
  Color.new("base07", palette.base07)
  Color.new("base08", palette.base08)
  Color.new("base09", palette.base09)
  Color.new("base0A", palette.base0A)
  Color.new("base0B", palette.base0B)
  Color.new("base0C", palette.base0C)
  Color.new("base0D", palette.base0D)
  Color.new("base0E", palette.base0E)
  Color.new("base0F", palette.base0F)

  -- init main colors for theme
  Color.new("white", palette.white)
  Color.new("black", palette.black)
  Color.new("grey", palette.grey)
  Color.new("red", palette.red)
  Color.new("pink", palette.pink)
  Color.new("green", palette.green)
  Color.new("blue", palette.blue)
  Color.new("yellow", palette.yellow)
  Color.new("purple", palette.purple)
  Color.new("teal", palette.teal)
  Color.new("orange", palette.orange)
  Color.new("cyan", palette.cyan)
  Color.new("line", palette.line)
  Color.new("statusline_bg", palette.statusline_bg)
  Color.new("pmenu_bg", palette.pmenu_bg)
  Color.new("folder_bg", palette.folder_bg)

  -- apply highlights
  require("colors.highlights.base")
  require("colors.highlights.syntax")
  require("colors.highlights.integrations")
end

return M
