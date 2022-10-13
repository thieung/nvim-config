local c = require("colors.utils").colors
local Group = require("colors.utils").Group

Group.new("NotifyERRORBorder", c.red)
Group.new("NotifyERRORIcon", c.red)
Group.new("NotifyERRORTitle", c.red)
Group.new("NotifyWARNBorder", c.yellow:dark())
Group.new("NotifyWARNIcon", c.yellow:dark())
Group.new("NotifyWARNTitle", c.yellow:dark())
Group.new("NotifyDEBUGBorder", c.pink)
Group.new("NotifyDEBUGIcon", c.pink)
Group.new("NotifyDEBUGTitle", c.pink)
Group.new("NotifyINFOBorder", c.green)
Group.new("NotifyINFOIcon", c.green)
Group.new("NotifyINFOTitle", c.green)
Group.new("NotifyTRACEBorder", c.purple)
Group.new("NotifyTRACEIcon", c.purple)
Group.new("NotifyTRACETitle", c.purple)
