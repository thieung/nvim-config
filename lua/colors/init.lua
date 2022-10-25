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

  require("utils").General.reload_modules("colors.highlights")

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

  Color.new("statusline_bg", palette.statusline_bg)
  Color.new("pmenu_bg", palette.pmenu_bg)
  Color.new("folder_bg", palette.folder_bg)
  Color.new("line", palette.line)

  Color.new("light_grey", palette.light_grey or palette.grey)
  Color.new("comment_grey", palette.comment_grey or palette.grey)
  Color.new("cursor_grey", palette.cursor_grey or palette.grey)
  Color.new("visual_grey", palette.visual_grey or palette.grey)
  Color.new("menu_grey", palette.menu_grey or palette.grey)
  Color.new("special_grey", palette.special_grey or palette.grey)

  Color.new("dark_cyan", palette.dark_cyan or palette.cyan)
  Color.new("dark_red", palette.dark_red or palette.red)
  Color.new("dark_yellow", palette.dark_yellow or palette.yellow)
  Color.new("dark_purple", palette.dark_purple or palette.purple)

  Color.new("diff_add", palette.diff_add or palette.green)
  Color.new("diff_delete", palette.diff_delete or palette.red)
  Color.new("diff_change", palette.diff_change or palette.yellow)
  Color.new("diff_text", palette.diff_text or palette.blue)

  -- apply highlights
  require("colors.highlights.base")
  require("colors.highlights.syntax")
  require("colors.highlights.integrations")

  -- terminal colors
  local g = vim.g
  g.terminal_color_0 = palette.base01
  g.terminal_color_1 = palette.base08
  g.terminal_color_2 = palette.base0B
  g.terminal_color_3 = palette.base0A
  g.terminal_color_4 = palette.base0D
  g.terminal_color_5 = palette.base0E
  g.terminal_color_6 = palette.base0C
  g.terminal_color_7 = palette.base05
  g.terminal_color_8 = palette.base03
  g.terminal_color_9 = palette.base08
  g.terminal_color_10 = palette.base0B
  g.terminal_color_11 = palette.base0A
  g.terminal_color_12 = palette.base0D
  g.terminal_color_13 = palette.base0E
  g.terminal_color_14 = palette.base0C
  g.terminal_color_15 = palette.base07
  g.terminal_color_background = g.terminal_color_0
  g.terminal_color_foreground = g.terminal_color_7
end

return M
