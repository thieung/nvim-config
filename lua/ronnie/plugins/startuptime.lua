return {
	"dstein64/vim-startuptime", -- Profile Neovim startup time
	cmd = "StartupTime",
	init = function()
		require("legendary").commands({
			{
				":StartupTime",
				description = "Profile Neovim's startup time",
			},
		})
	end,
	config = function()
		vim.g.startuptime_tries = 15
		vim.g.startuptime_exe_args = { "+let g:auto_session_enabled = 0" }
	end,
}
