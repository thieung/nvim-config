local M = {
  "mrjones2014/legendary.nvim", -- A command palette for keymaps, commands and autocmds
  priority = 900,
  dependencies = "kkharji/sqlite.lua",
}

function M.config()
  local legendary = require("legendary")

  legendary.setup({
    select_prompt = "Legendary",
    include_builtin = false,
    include_legendary_cmds = false,
    which_key = { auto_register = false },

    keymaps = require(namespace .. ".keymaps"),
    autocmds = require(namespace .. ".autocmds"),
    commands = require(namespace .. ".commands"),
  })

  legendary.keymaps({
    {
      "<C-p>",
      require("legendary").find,
      hide = true,
      description = "Open Legendary",
      mode = { "n", "v" },
    },
  })
end

return M

