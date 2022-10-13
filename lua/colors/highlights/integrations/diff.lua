local c = require("colors.utils").colors
local Group = require("colors.utils").Group

Group.new("DiffAdd", c.black, c.green:light())
Group.new("DiffChange", c.black, c.green)
Group.new("DiffDelete", c.black, c.red)
Group.new("DiffText", c.white, c.blue:dark())
Group.new("DiffAdded", c.green)
Group.new("DiffChangeDelete", c.red)
Group.new("DiffModified", c.yellow)
Group.new("DiffRemoved", c.red)
Group.new("diffAdded", c.green)
Group.new("diffRemoved", c.red)
Group.new("diffChanged", c.yellow)
Group.new("diffOldFile", c.orange)
Group.new("diffNewFile", c.green)
Group.new("diffFile", c.cyan)
Group.new("diffLine", c.black)
Group.new("diffIndexLine", c.white)
