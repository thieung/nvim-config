local c = require("colors.utils").colors
local s = require("colors.utils").styles
local g = require("colors.utils").groups
local Group = require("colors.utils").Group

Group.new("InclineNormal", g.StatusLine, g.StatusLine)
Group.new("InclineNormalNC", g.StatusLineNC)
