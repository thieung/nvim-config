local M = {
	"nvim-neo-tree/neo-tree.nvim", -- File explorer
	cmd = "Neotree",
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
}

function M.init()
	require("legendary").keymaps({
		{ "<C-n>", "<cmd>Neotree toggle<CR>", hide = true, description = "Neotree: Toggle" },
		{ "<C-z>", "<cmd>Neotree reveal=true toggle<CR>", hide = true, description = "Neotree: Reveal File" },
	})
end

function M.config()
	require("neo-tree").setup({
		close_if_last_window = true,
		enable_git_status = true,
		enable_diagnostics = false,
		default_component_configs = {
			icon = {
				folder_open = "",
				folder_closed = "",
				folder_empty = "ﰊ",
				default = "*",
			},
			indent = {
				with_markers = false,
			},
			modified = {
				symbol = "[+]",
				highlight = "NeoTreeModified",
			},
		},
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
			},
		},
		window = {
			width = 40,
		},
	})
end

return M
