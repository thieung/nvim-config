return {
	"lewis6991/gitsigns.nvim", -- Git signs in the sign column
	event = "BufReadPre",
	config = {
		keymaps = {}, -- Do not use the default mappings
		signs = {
			add = { hl = "GitSignsAdd", text = "+", show_count = false },
			change = { hl = "GitSignsChange", text = "~", show_count = false },
			delete = { hl = "GitSignsDelete", text = "-", show_count = true },
			topdelete = { hl = "GitSignsDelete", text = "-", show_count = true },
			changedelete = { hl = "GitSignsChange", text = "-", show_count = true },
		},
		current_line_blame = true,
		current_line_blame_formatter_opts = {
			relative_time = true
		},
		current_line_blame_opts = {
			delay = 100
		},
		count_chars = {
			'⒈', '⒉', '⒊', '⒋', '⒌', '⒍', '⒎', '⒏', '⒐',
			'⒑', '⒒', '⒓', '⒔', '⒕', '⒖', '⒗', '⒘', '⒙', '⒚', '⒛',
		},
		update_debounce = 50,

	}
}
