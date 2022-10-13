local c = require("colors.utils").colors
local Group = require("colors.utils").Group

Group.new("markdownCode", c.blue:dark())
Group.new("markdownCodeBlock", c.blue:dark())
Group.new("markdownH1", c.yellow)
Group.new("markdownH2", c.yellow)
Group.new("markdownH3", c.yellow)
Group.new("markdownH4", c.yellow)
Group.new("markdownH5", c.yellow)
Group.new("markdownH6", c.yellow)
Group.new("markdownHeadingDelimiter", c.orange:dark())
Group.new("markdownLinkText", c.blue:dark())
