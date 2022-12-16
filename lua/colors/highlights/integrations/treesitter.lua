local c = require("colors.utils").colors
local s = require("colors.utils").styles
local g = require("colors.utils").groups
local Group = require("colors.utils").Group

--- misc
Group.new("@annotation", c.base0F)
Group.new("@error", c.red)
Group.new("@operator", c.base05)
Group.new("@structure", g.Structure)

--- literals
Group.new("@string", c.base0B)
Group.new("@string.escape", c.base0C)
Group.new("@string.regex", c.base0C)
Group.new("@string.special", c.base0B, nil, s.italic)
Group.new("@character", c.base08)
Group.new("@character.special", c.base08)
Group.new("@number", c.base09)
Group.new("@float", c.base09)
Group.new("@boolean", c.base09)

--- functions
Group.new("@function", c.base0D)
Group.new("@function.call", c.base0D)
Group.new("@function.builtin", c.base0D)
Group.new("@function.macro", c.base08)
Group.new("@method", c.base0D)
Group.new("@method.call", c.base0D)
Group.new("@constructor", c.base0C)
Group.new("@parameter", c.base08)
Group.new("@parameter.reference", c.base05)

--- keywords
Group.new("@keyword", c.base0E)
Group.new("@keyword.function", c.base0E)
Group.new("@keyword.operator", c.base0E)
Group.new("@keyword.return", c.base0E)
Group.new("@conditional", g.Conditional)
Group.new("@repeat", c.purple)
Group.new("@debug", c.pink)
Group.new("@label", c.base0A)
Group.new("@include", g.Include)
Group.new("@exception", c.red)

--- types
Group.new("@type", g.Type)
Group.new("@type.builtin", g.Type)
Group.new("@attribute", c.base0A)
Group.new("@field", c.base0D)
Group.new("@property", c.base08)

--- identifiers
Group.new("@variable", c.base05)
Group.new("@variable.builtin", c.base09)
Group.new("@constant", c.base09)
Group.new("@constant.builtin", c.base09)
Group.new("@constant.macro", c.base08)
Group.new("@namespace", c.base08)
Group.new("@symbol", c.base0B)

-- punctuations
Group.new("@punctuation.bracket", c.base0F)
Group.new("@punctuation.delimiter", c.base0F)
Group.new("@punctuation.special", c.base08)

--- tags
Group.new("@tag", c.yellow)
Group.new("@tag.attribute", c.base0A) -- link to @attribute
Group.new("@tag.delimiter", c.base0F)

--- texts
Group.new("@text", c.base05)
Group.new("@text.strong", c.white, nil, s.bold)
Group.new("@text.strike", c.base00, nil, s.strikethrough)
Group.new("@text.emphasis", c.base09, nil, s.italic)
Group.new("@text.underline", c.base0B, nil, s.underline)
Group.new("@text.title", c.yellow, nil, s.bold)
Group.new("@text.uri", c.base09, nil, s.underline)
Group.new("@text.todo", c.pink, nil, s.bold)
Group.new("@text.note", c.green, nil, s.bold)
Group.new("@text.warning", c.yellow, nil, s.bold)
Group.new("@text.danger", c.red:light(), nil, s.bold)

--- treesitter-context
Group.new("TreesitterContext", nil, c.cursor_grey)
Group.new("TreesitterContextLineNumber", c.blue, c.cursor_grey)

-- others
Group.new("luaTSField", c.base0D)
