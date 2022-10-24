vim.opt.bg = "dark"

return {
  -- base16 colors
  -- https://github.com/LalitMaganti/base16-onedark-scheme/blob/master/onedark.yaml
  base00 = "#1e222a", -- Default bg, alternative: "#282c34"
  base01 = "#353b45", -- Lighter bg (status bars, line number, folding marks)
  base02 = "#3e4451", -- Selection bg
  base03 = "#545862", -- Comments, Invisibles, Line Highlighting
  base04 = "#565c64", -- Dark fg (status bars)
  base05 = "#abb2bf", -- Default Fg (Caret, Delimiters, Operators)
  base06 = "#b6bdca", -- Light fg (Not often used)
  base07 = "#c8ccd4", -- Light bg (Not often used)
  base08 = "#e06c75", -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
  base09 = "#d19a66", -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
  base0A = "#e5c07b", -- Classes, Markup Bold, Search Text Background
  base0B = "#98c379", -- Strings, Inherited Class, Markup Code, Diff Inserted
  base0C = "#56b6c2", -- Support, Regular Expressions, Escape Characters, Markup Quotes
  base0D = "#61afef", -- Functions, Methods, Attribute IDs, Headings
  base0E = "#c678dd", -- Keywords, Storage, Selector, Markup Italic, Diff Changed
  base0F = "#be5046", -- Deprecated, Opening/Closing Embedded Language Tags

  -- main colors
  -- https://github.com/joshdick/onedark.vim
  -- https://github.com/ii14/onedark.nvim/blob/master/lua/onedark/colors.lua
  -- https://github.com/NvChad/base46/blob/master/lua/base46/themes/onedark.lua
  white = "#abb2bf",
  black = "#181a1f",
  grey = "#5c6370",
  red = "#E06C75",
  pink = "#ff75a0",
  green = "#98c379",
  blue = "#61afef",
  yellow = "#e5c07b",
  purple = "#c678dd",
  teal = "#519ABA",
  orange = "#d19a66",
  cyan = "#56b6c2",

  light_grey = "#848b98",
  comment_grey = "#5C6370",
  cursor_grey = "#2C323C",
  visual_grey = "#3E4452",
  menu_grey = "#3E4452",
  special_grey = "#3B4048",

  dark_cyan = "#2b6f77", -- ~40% darker of cyan
  dark_red = "#993939", -- ~70% darker of red
  dark_yellow = "#93691d", -- ~70% darker of yellow
  dark_purple = "#8a3fa0", -- ~60% darker of purple

  pmenu_bg = "#73b8f1",
  folder_bg = "#61afef",
  statusline_bg = "#22262e",
  line = "#181A1F", -- for lines like vertsplit

  diff_add = "#31392b",
  diff_delete = "#382b2c",
  diff_change = "#1c3448",
  diff_text = "#2c5372",
}
