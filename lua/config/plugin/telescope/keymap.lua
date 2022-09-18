local keymap = require("utils").Keymap
local map, leader, n = keymap.map, keymap.modifier.leader, keymap.mode.normal
local telescope_builtin = require("telescope.builtin")
local telescope_theme = require("telescope.themes")

keymap.bind({
  -- find
  n(map(leader("ff"), function()
    telescope_builtin.find_files()
  end)),
  n(map(leader("fa"), function()
    telescope_builtin.find_files({ hidden = true, no_ignore = true })
  end)),
  n(map(leader("fw"), function()
    telescope_builtin.live_grep()
  end)),
  n(map(leader("fW"), function()
    telescope_builtin.live_grep({
      additional_args = function(args)
        return vim.list_extend(args, { "--hidden", "--no-ignore" })
      end,
    })
  end)),
  n(map(leader("fb"), function()
    telescope_builtin.buffers()
  end)),
  n(map(leader("fo"), function()
    telescope_builtin.oldfiles()
  end)),
  n(map(leader("fc"), function()
    telescope_builtin.grep_string()
  end)),
  n(map(leader("fe"), function()
    require("telescope").extensions.file_browser.file_browser()
  end)), -- telescope file browser

  -- git
  n(map(leader("gb"), function()
    telescope_builtin.git_branches()
  end)),
  n(map(leader("gc"), function()
    telescope_builtin.git_commits()
  end)),
  n(map(leader("gS"), function()
    telescope_builtin.git_status()
  end)),

  -- diagnostics
  n(map(leader("ld"), function()
    telescope_builtin.diagnostics(telescope_theme.get_dropdown({
      bufnr = 0,
    }))
  end)),
  n(map(leader("lD"), function()
    telescope_builtin.diagnostics()
  end)),
}, {})
