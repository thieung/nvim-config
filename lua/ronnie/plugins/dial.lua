return {
	"monaqa/dial.nvim",
	keys = {
		{
			"<C-a>",
			"<C-x>",
		},
	},
	init = function()
		local dial = require("dial.map")
		require("legendary").keymaps({
			{
				"<C-a>",
				{
					n = function()
						dial.inc_normal()
					end,
					v = function()
						dial.inc_visual()
					end,
				},
				description = "Dial increment",
			},
			{
				"<C-x>",
				n = function()
					dial.dec_normal()
				end,
				v = function()
					dial.dec_visual()
				end,
				description = "Dial decrement",
			},
		})
	end,
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal,
				augend.integer.alias.hex,
				augend.date.alias["%Y/%m/%d"],
				augend.constant.alias.bool,
			},
		})
	end
}
