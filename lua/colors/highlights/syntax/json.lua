local c = require("colors.utils").colors
local s = require("colors.utils").styles
local Group = require("colors.utils").Group

Group.new("jsonBoolean", c.pink:dark(), nil, s.italic)
Group.new("jsonEscape", c.yellow)
Group.new("jsonKeyword", c.yellow)
Group.new("jsonNull", c.pink:dark(), nil, s.italic)
