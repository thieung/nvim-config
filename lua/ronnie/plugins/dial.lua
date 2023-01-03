local M = {
	"monaqa/dial.nvim",
	keys = {
		{
			"<C-a>",
			"<C-x>",
		},
	},
}

function M.config()
	local augend = require("dial.augend")
	require("dial.config").augends:register_group({
		default = {
			augend.integer.alias.decimal,
			augend.integer.alias.hex,
			augend.date.alias["%Y/%m/%d"],
			augend.constant.alias.bool,
		},
	})

	require("legendary").keymaps({
		{
			"<C-a>",
			function()
				return require("dial.map").inc_normal()
			end,
			description = "Dial increment",
		},
		{
			"<C-x>",
			function()
				return require("dial.map").dec_normal()
			end,
			description = "Dial decrement",
		},
	})

end

return M
