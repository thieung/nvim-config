local c = require("colors.utils").colors
local s = require("colors.utils").styles
local g = require("colors.utils").groups
local Group = require("colors.utils").Group

Group.new("TSAnnotation", c.base0F)
Group.new("TSAttribute", c.base0A)
Group.new("TSBoolean", c.base09)
Group.new("TSCharacter", c.base08)
Group.new("TSConditional", g.Conditional)
Group.new("TSConstBuiltin", c.base09)
Group.new("TSConstMacro", c.base08)
Group.new("TSConstant", c.base09)
Group.new("TSConstructor", c.base0C)
Group.new("TSCurrentScope", nil, nil, s.bold)
Group.new("TSEmphasis", c.base09)
Group.new("TSError", c.red)
Group.new("TSException", c.red)
Group.new("TSField", c.base0D)
Group.new("TSFieldKey", c.base08)
Group.new("TSFloat", c.base09)
Group.new("TSFuncBuiltin", c.base0D)
Group.new("TSFuncMacro", c.base08)
Group.new("TSFunction", c.base0D)
Group.new("TSInclude", g.Include)
Group.new("TSKeyword", c.base0E)
Group.new("TSKeywordFunction", c.base0E)
Group.new("TSKeywordOperator", c.base0E)
Group.new("TSLabel", c.base0A)
Group.new("TSLiteral", c.base09)
Group.new("TSMethod", c.base0D)
Group.new("TSNamespace", c.base08)
Group.new("TSNumber", c.base09)
Group.new("TSOperator", c.base05)
Group.new("TSParameter", c.base08)
Group.new("TSParameterReference", c.base05)
Group.new("TSProperty", c.base08)
Group.new("TSPunctBracket", c.base0F)
Group.new("TSPunctDelimiter", c.base0F)
Group.new("TSPunctSpecial", c.base08)
Group.new("TSRepeat", c.pink:dark())
Group.new("TSStrike", c.base00, nil, s.strikethrough)
Group.new("TSString", c.base0B)
Group.new("TSStringEscape", g.TSString)
Group.new("TSStringRegex", g.TSString)
Group.new("TSStringSpecial", g.TSString)
Group.new("TSStrong", c.white, nil, s.bold)
Group.new("TSStructure", g.Structure)
Group.new("TSSymbol", c.base0B)
Group.new("TSTag", c.yellow)
Group.new("TSTagAttribute", g.TSProperty)
Group.new("TSTagDelimiter", c.base0F)
Group.new("TSText", c.base05)
Group.new("TSTitle", c.yellow, nil, s.bold)
Group.new("TSType", g.Type)
Group.new("TSTypeBuiltin", g.Type)
Group.new("TSURI", c.base09, nil, s.underline)
Group.new("TSUnderline", c.base0B, nil, s.underline)
Group.new("TSVariable", c.base05)
Group.new("TSVariableBuiltin", c.base09)

-- others
Group.new("luaTSField", c.base0D)
