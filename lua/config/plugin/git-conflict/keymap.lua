local keymap = require("utils").Keymap
local map, n, modifier = keymap.map, keymap.mode.normal, keymap.modifier
local ex, plug = modifier.ex, modifier.plug

keymap.bind({
  n(map("Cc", plug("(git-conflict-ours)"))), -- take current
  n(map("Ci", plug("(git-conflict-theirs)"))), -- take incoming
  n(map("Cb", plug("(git-conflict-both)"))), -- take both
  n(map("C0", plug("(git-conflict-none)"))), -- take none
  n(map("Cr", ex("GitConflictRefresh"))), -- refresh conflicts
  n(map("Cl", ex("GitConflictListQf"))), -- list conflicts
  n(map("]C", plug("(git-conflict-next-conflict)"))), -- next conflict
  n(map("[C", plug("(git-conflict-prev-conflict)"))), -- previous conflict
})
