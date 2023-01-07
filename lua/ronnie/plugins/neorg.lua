return {
  "nvim-neorg/neorg",
  ft = "norg",
	dependencies = {
		"nvim-neorg/neorg-telescope",
	},
	init = function ()
		require("legendary").keymaps({
			{
				"<LocalLeader>ov",
				"<cmd>Neorg gtd views<CR>",
				hide = true,
				description = "View neorg"
			}
		})
	end,
  config = {
		configure_parsers = true,
    load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {},
      ["core.norg.completion"] = {
        config = { engine = "nvim-cmp" },
      },
      ["core.integrations.nvim-cmp"] = {},
			["core.integrations.telescope"] = {},
    },
  },
}

