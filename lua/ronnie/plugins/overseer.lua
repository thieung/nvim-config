local M = {
	"stevearc/overseer.nvim", -- Task runner and job management
}

M.config = {
	component_aliases = {
		default_neotest = {
			"on_output_summarize",
			"on_exit_set_status",
			"on_complete_dispose",
		},
	},
}

return M
