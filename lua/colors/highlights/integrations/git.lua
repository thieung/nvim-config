local c = require("colors.utils").colors
local s = require("colors.utils").styles
local Group = require("colors.utils").Group

-- gitcommit
-- https://github.com/vim/vim/blob/master/runtime/syntax/gitcommit.vim
Group.new("gitcommitOverflow", c.base08)
Group.new("gitcommitSummary", c.base08)
Group.new("gitcommitComment", c.base03)
Group.new("gitcommitUntracked", c.base03)
Group.new("gitcommitDiscarded", c.base03)
Group.new("gitcommitSelected", c.base03)
Group.new("gitcommitHeader", c.base0E)
Group.new("gitcommitSelectedType", c.base0D)
Group.new("gitcommitUnmergedType", c.base0D)
Group.new("gitcommitDiscardedType", c.base0D)
Group.new("gitcommitBranch", c.base09, nil, s.bold)
Group.new("gitcommitUntrackedFile", c.base0A)
Group.new("gitcommitUnmergedFile", c.base08, nil, s.bold)
Group.new("gitcommitDiscardedFile", c.base08, nil, s.bold)
Group.new("gitcommitSelectedFile", c.base0B, nil, s.bold)

-- GitSigns
Group.new("GitSignsAdd", c.green)
Group.new("GitSignsAddNr", c.blue)
Group.new("GitSignsAddLn", c.blue)
Group.new("GitSignsChange", c.yellow)
Group.new("GitSignsChangeNr", c.purple)
Group.new("GitSignsChangeLn", c.purple)
Group.new("GitSignsDelete", c.red)
Group.new("GitSignsDeleteNr", c.red)
Group.new("GitSignsDeleteLn", c.red)
Group.new("GitSignsCurrentLineBlame", c.orange)
