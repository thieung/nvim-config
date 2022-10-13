vim.opt.bg = "dark"

return {
  -- base16 colors
  base00 = "#181a1f", -- Default bg
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
  white = "#abb2bf",
  black = "#181a1f",
  -- darker_black = "#1b1f27", -- 6% darker than black
  -- lighter_black = "#252931", -- 6% lighter than black
  -- one_bg = "#282c34", -- ~10% lighter than black
  -- one_bg2 = "#353b45", -- ~19% lighter than black
  -- one_bg3 = "#373b43", -- ~27% lighter than black
  grey = "#5c6370", -- ~40% lighter than black
  -- grey_fg = "#565c64", -- 10% lighter than grey
  -- grey_fg2 = "#6f737b", -- 20% lighter than greyk
  -- light_grey = "#6f737b", -- 28% lighter than grey
  red = "#e86671",
  pink = "#ff75a0",
  green = "#98c379",
  blue = "#61afef",
  yellow = "#e5c07b",
  purple = "#c678dd",
  teal = "#519ABA",
  orange = "#d19a66",
  cyan = "#56b6c2",
  line = "#31353d", -- for lines like vertsplit
  statusline_bg = "#22262e", -- 4% lighter than black
  pmenu_bg = "#61afef",
  folder_bg = "#61afef",
}
