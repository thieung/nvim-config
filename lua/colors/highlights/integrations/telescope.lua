local c = require("colors.utils").colors
local s = require("colors.utils").styles
local Group = require("colors.utils").Group

-- General
Group.new("TelescopeBorder", c.yellow)
Group.new("TelescopeMatching", c.yellow)
Group.new("TelescopeMultiSelection", c.pink:dark())
Group.new("TelescopeNormal", c.white)
Group.new("TelescopePreviewBorder", c.blue)
Group.new("TelescopeSelection", c.blue, c.black:light(0.06))
Group.new("TelescopeSelectionCaret", c.yellow, c.black:light(0.06))

-- Prompt
Group.new("TelescopePrompt", c.yellow)
Group.new("TelescopePromptBorder", c.blue)
Group.new("TelescopePromptCounter", c.grey:light())
Group.new("TelescopePromptPrefix", c.orange:dark())

-- Results
Group.new("TelescopeResultsBorder", c.blue)
Group.new("TelescopeResultsClass", c.purple, nil, s.italic)
Group.new("TelescopeResultsConstant", c.grey:light(), nil, s.italic)
Group.new("TelescopeResultsField", c.blue:light(), nil, s.italic)
Group.new("TelescopeResultsFunction", c.pink:light(), nil, s.italic)
Group.new("TelescopeResultsIdentifier", c.yellow:light(), nil, s.italic)
Group.new("TelescopeResultsMethod", c.yellow, nil, s.italic)
Group.new("TelescopeResultsNormal", c.white)
Group.new("TelescopeResultsNumber", c.pink:dark())
Group.new("TelescopeResultsOperator", c.blue:light(), nil, s.italic)
Group.new("TelescopeResultsSpecialComment", c.blue, nil, s.italic)
Group.new("TelescopeResultsStruct", c.orange:light(), nil, s.italic)
Group.new("TelescopeResultsTitle", c.yellow)
Group.new("TelescopeResultsVariable", c.green:light(), nil, s.italic)

-- Diff
Group.new("TelescopeResultsDiffAdd", c.black, c.green)
Group.new("TelescopeResultsDiffChange", c.black, c.green:light())
Group.new("TelescopeResultsDiffDelete", c.white, c.red)
Group.new("TelescopeResultsDiffUntracked", c.black, c.blue:light())
