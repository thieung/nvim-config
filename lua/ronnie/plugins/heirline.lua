local M = {
	"rebelot/heirline.nvim",
	priority = 500,
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"famiu/bufdelete.nvim", -- Easily close buffers whilst preserving your window layouts
	},
}

-- Filetypes where certain elements of the statusline will not be shown
local filetypes = {
	"^aerial$",
	"^neo--tree$",
	"^neotest--summary$",
	"^neo--tree--popup$",
	"^NvimTree$",
	"^toggleterm$",
	"^FTerm$",
}

-- Filetypes which force the statusline to be inactive
local force_inactive_filetypes = {
	"^alpha$",
	"^DressingInput$",
	"^frecency$",
	"^lazy$",
	"^netrw$",
	"^TelescopePrompt$",
	"^undotree$",
}

---The tabline for the bufferline
---@return table
local function tabline()
	local heirline = require("heirline")
	local utils = require("heirline.utils")
	local conditions = require("heirline.conditions")

	local Tabpage = {
		provider = function(self) return "%" .. self.tabnr .. "T " .. self.tabnr .. " %T" end,
		hl = function(self)
			if not self.is_active then
				return "TabLine"
			else
				return "TabLineSel"
			end
		end,
	}

	local TabpageClose = {
		provider = "%999X  %X",
		hl = { fg = "gray" },
	}

	local TabPages = {
		-- only show this component if there's 2 or more tabpages
		condition = function() return #vim.api.nvim_list_tabpages() >= 2 end,
		{ provider = "%=" },
		utils.make_tablist(Tabpage),
		TabpageClose,
	}

	return TabPages
end

---The bufferline
---@return table
local function bufferline()
	local heirline = require("heirline")
	local utils = require("heirline.utils")
	local conditions = require("heirline.conditions")

	local buffers = {}

	table.unpack = table.unpack or unpack -- 5.1 compatibility

	---Get the names of all current listed buffers
	---@return table
	local function get_current_filenames()
		local listed_buffers = vim.tbl_filter(
			function(bufnr) return vim.bo[bufnr].buflisted and vim.api.nvim_buf_is_loaded(bufnr) end,
			vim.api.nvim_list_bufs()
		)

		return vim.tbl_map(vim.api.nvim_buf_get_name, listed_buffers)
	end

	---Get unique name for the current buffer
	---@param filename string
	---@param shorten boolean
	---@return string
	local function get_unique_filename(filename, shorten)
		local filenames = vim.tbl_filter(
			function(filename_other) return filename_other ~= filename end,
			get_current_filenames()
		)

		if shorten then
			filename = vim.fn.pathshorten(filename)
			filenames = vim.tbl_map(vim.fn.pathshorten, filenames)
		end

		-- Reverse filenames in order to compare their names
		filename = string.reverse(filename)
		filenames = vim.tbl_map(string.reverse, filenames)

		local index

		-- For every other filename, compare it with the name of the current file char-by-char to
		-- find the minimum index `i` where the i-th character is different for the two filenames
		-- After doing it for every filename, get the maximum value of `i`
		if next(filenames) then
			index = math.max(table.unpack(vim.tbl_map(function(filename_other)
				for i = 1, #filename do
					-- Compare i-th character of both names until they aren't equal
					if filename:sub(i, i) ~= filename_other:sub(i, i) then return i end
				end
				return 1
			end, filenames)))
		else
			index = 1
		end

		-- Iterate backwards (since filename is reversed) until a "/" is found
		-- in order to show a valid file path
		while index <= #filename do
			if filename:sub(index, index) == "/" then
				index = index - 1
				break
			end

			index = index + 1
		end

		return string.reverse(string.sub(filename, 1, index))
	end

	---Trim a filename
	---@param filename string
	---@param char_limit number
	---@param truncate? string
	---@return string
	local function trim_filename(filename, char_limit, truncate)
		truncate = truncate or " "

		-- Ensure that with the truncation icon, we don't go over the char limit
		if (#filename + #truncate) > char_limit then char_limit = char_limit - #truncate end

		if #filename > char_limit then filename = string.sub(filename, 1, char_limit) .. truncate end

		return filename
	end

	---Format a filename
	---@param filename string
	---@param char_limit? number
	---@return string
	local function format_filename(filename, char_limit)
		filename = get_unique_filename(filename, false)

		char_limit = char_limit or 18
		local pad = math.ceil((char_limit - #filename) / 2)
		return string.rep(" ", pad) .. trim_filename(filename, char_limit) .. string.rep(" ", pad)
	end

	-- Navigate to buffers with keystrokes
	local TablinePicker = {
		condition = function(self) return self._show_picker end,
		init = function(self)
			local bufname = vim.api.nvim_buf_get_name(self.bufnr)
			bufname = vim.fn.fnamemodify(bufname, ":t")
			local label = bufname:sub(1, 1)
			local i = 2
			while self._picker_labels[label] do
				if i > #bufname then break end
				label = bufname:sub(i, i)
				i = i + 1
			end
			self._picker_labels[label] = self.bufnr
			self.label = label
		end,
		provider = function(self) return self.label .. ": " end,
		hl = { fg = "red", bold = true, italic = true },
	}

	local TablineBufnr = {
		condition = function(self) return not self._show_picker end,
		provider = function(self) return tostring(self.bufnr) .. ": " end,
		hl = function(self) return { fg = self.is_active and "purple" or "gray", italic = true } end,
	}

	local TablineFileName = {
		provider = function(self)
			local filename = self.filename
			filename = filename == "" and "[No Name]" or format_filename(vim.fn.fnamemodify(filename, ":t:r"), 15)
			return filename
		end,
		hl = function(self)
			return {
				fg = self.is_active and utils.get_highlight("HeirlineBufferline").fg or "gray",
				bg = "bg",
				bold = self.is_active or self.is_visible,
			}
		end,
	}

	local TablineFileFlags = {
		{
			condition = function(self) return vim.api.nvim_buf_get_option(self.bufnr, "modified") end,
			provider = " ",
			hl = { fg = "red" },
		},
		{
			condition = function(self)
				return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
						or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
			end,
			provider = function(self)
				if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
					return "  "
				else
					return " "
				end
			end,
			hl = { fg = "blue" },
		},
	}

	local TablineFileNameBlock = {
		init = function(self) self.filename = vim.api.nvim_buf_get_name(self.bufnr) end,
		hl = { bg = "bg" },
		on_click = {
			callback = function(_, minwid, _, button)
				if button == "m" then -- close on mouse middle click
					vim.api.nvim_buf_delete(minwid, { force = false })
				else
					vim.api.nvim_win_set_buf(0, minwid)
				end
			end,
			minwid = function(self) return self.bufnr end,
			name = "heirline_tabline_buffer_callback",
		},
		TablinePicker,
		TablineBufnr,
		TablineFileName,
		TablineFileFlags,
	}

	local TablineBufferBlock = utils.surround({ " ", " " }, function(self) end, { TablineFileNameBlock })

	local BufferLine = utils.make_buflist(
		TablineBufferBlock,
		{ provider = " ", hl = { fg = "gray" } },
		{ provider = " ", hl = { fg = "gray" } }
	)

	local BufferLineOffset = {
		condition = function(self)
			local win = vim.api.nvim_tabpage_list_wins(0)[1]
			local bufnr = vim.api.nvim_win_get_buf(win)
			self.winid = win

			if vim.bo[bufnr].filetype == "neo-tree" then
				self.title = "NeoTree"
				return true
			elseif vim.bo[bufnr].filetype == "aerial" then
				self.title = "Aerial"
				return true
			end
		end,

		provider = function(self)
			local title = self.title
			local width = vim.api.nvim_win_get_width(self.winid)
			local pad = math.ceil((width - #title) / 2)
			return string.rep(" ", pad) .. title .. string.rep(" ", pad)
		end,

		hl = function(self)
			if vim.api.nvim_get_current_win() == self.winid then
				return { fg = "purple", bold = true }
			else
				return "Tabline"
			end
		end,
	}

	local VimLogo = {
		provider = function(self) return "    " end,
		hl = { fg = "vim" },
	}

	return { BufferLineOffset, VimLogo, BufferLine, tabline() }
end

---The statusline
---@return table
local function statusline()
	local utils = require("heirline.utils")
	local conditions = require("heirline.conditions")

	local Align = { provider = "%=" }
	local Space = { provider = " " }

	local LeftSlantStart = {
		provider = "",
		hl = { fg = "bg", bg = "statusline_bg" },
	}
	local LeftSlantEnd = {
		provider = "",
		hl = { fg = "statusline_bg", bg = "bg" },
	}
	local RightSlantStart = {
		provider = "",
		hl = { fg = "statusline_bg", bg = "bg" },
	}
	local RightSlantEnd = {
		provider = "",
		hl = { fg = "bg", bg = "statusline_bg" },
	}



	---Return the current vim mode
	local VimMode = {
		init = function(self)
			self.mode = vim.fn.mode(1)
			self.mode_color = self.mode_colors[self.mode:sub(1, 1)]

			if not self.once then
				vim.api.nvim_create_autocmd("ModeChanged", {
					pattern = "*:*o",
					command = "redrawstatus",
				})
				self.once = true
			end
		end,
		static = {
			mode_names = {
				n = "NORMAL",
				no = "NORMAL",
				nov = "NORMAL",
				noV = "NORMAL",
				["no\22"] = "NORMAL",
				niI = "NORMAL",
				niR = "NORMAL",
				niV = "NORMAL",
				nt = "NORMAL",
				v = "VISUAL",
				vs = "VISUAL",
				V = "VISUAL",
				Vs = "VISUAL",
				["\22"] = "VISUAL",
				["\22s"] = "VISUAL",
				s = "SELECT",
				S = "SELECT",
				["\19"] = "SELECT",
				i = "INSERT",
				ic = "INSERT",
				ix = "INSERT",
				R = "REPLACE",
				Rc = "REPLACE",
				Rx = "REPLACE",
				Rv = "REPLACE",
				Rvc = "REPLACE",
				Rvx = "REPLACE",
				c = "COMMAND",
				cv = "Ex",
				r = "...",
				rm = "M",
				["r?"] = "?",
				["!"] = "!",
				t = "TERM",
			},
			mode_colors = {
				n = "purple",
				i = "green",
				v = "orange",
				V = "orange",
				["\22"] = "orange",
				c = "orange",
				s = "yellow",
				S = "yellow",
				["\19"] = "yellow",
				r = "green",
				R = "green",
				["!"] = "red",
				t = "red",
			},
		},
		{
			provider = function(self) return " %2(" .. self.mode_names[self.mode] .. "%) " end,
			hl = function(self) return { fg = "bg", bg = self.mode_color } end,
			on_click = {
				callback = function() vim.cmd("Alpha") end,
				name = "heirline_mode",
			},
			update = {
				"ModeChanged",
			},
		},
		{
			provider = "",
			hl = function(self) return { fg = self.mode_color, bg = "bg" } end,
		},
	}

	---Return the current git branch in the cwd
	local GitBranch = {
		condition = conditions.is_git_repo,
		init = function(self) self.status_dict = vim.b.gitsigns_status_dict end,
		{
			condition = function()
				return not conditions.buffer_matches({
					filetype = filetypes,
				})
			end,
			LeftSlantStart,
			{
				provider = function(self) return "  " .. self.status_dict.head .. " " end,
				on_click = {
					callback = function() rn.ListBranches() end,
					name = "git_change_branch",
				},
				hl = { fg = "gray", bg = "statusline_bg" },
			},
			{
				condition = function() return (_G.GitStatus ~= nil and (_G.GitStatus.ahead ~= 0 or _G.GitStatus.behind ~= 0)) end,
				{
					condition = function() return _G.GitStatus.status == "pending" end,
					provider = " ",
					hl = { fg = "gray", bg = "statusline_bg" },
				},
				{
					provider = function() return _G.GitStatus.behind .. " " end,
					hl = function() return { fg = _G.GitStatus.behind == 0 and "gray" or "red", bg = "statusline_bg" } end,
					on_click = {
						callback = function()
							if _G.GitStatus.behind > 0 then rn.GitPull() end
						end,
						name = "git_pull",
					},
				},
				{
					provider = function() return _G.GitStatus.ahead .. " " end,
					hl = function() return { fg = _G.GitStatus.ahead == 0 and "gray" or "green", bg = "statusline_bg" } end,
					on_click = {
						callback = function()
							if _G.GitStatus.ahead > 0 then rn.GitPush() end
						end,
						name = "git_push",
					},
				},
			},
			LeftSlantEnd,
		},
	}

	---Return the filename of the current buffer
	local FileBlock = {
		init = function(self) self.filename = vim.api.nvim_buf_get_name(0) end,
		condition = function()
			return not conditions.buffer_matches({
				filetype = filetypes,
			})
		end,
	}

	local FileName = {
		provider = function(self)
			local filename = vim.fn.fnamemodify(self.filename, ":t")
			if filename == "" then return "[No Name]" end
			return " " .. filename .. " "
		end,
		on_click = {
			callback = function() vim.cmd("Telescope find_files") end,
			name = "find_files",
		},
		hl = { fg = "gray", bg = "statusline_bg" },
	}

	local FileFlags = {
		{
			condition = function() return vim.bo.modified end,
			provider = " ",
			hl = { fg = "gray" },
		},
		{
			condition = function() return not vim.bo.modifiable or vim.bo.readonly end,
			provider = " ",
			hl = { fg = "gray" },
		},
	}

	local FileNameBlock = utils.insert(FileBlock, LeftSlantStart, utils.insert(FileName, FileFlags), LeftSlantEnd)

	---Return the LspDiagnostics from the LSP servers
	local LspDiagnostics = {
		condition = conditions.has_diagnostics,
		init = function(self)
			self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
			self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
			self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
			self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
		end,
		on_click = {
			callback = function() vim.cmd("normal gf") end,
			name = "heirline_diagnostics",
		},
		update = { "DiagnosticChanged", "BufEnter" },
		-- Errors
		{
			condition = function(self) return self.errors > 0 end,
			hl = { fg = "bg", bg = "red" },
			{
				{
					provider = "",
				},
				{
					provider = function(self) return vim.fn.sign_getdefined("DiagnosticSignError")[1].text .. self.errors end,
				},
				{
					provider = "",
					hl = { bg = "bg", fg = "red" },
				},
			},
		},
		-- Warnings
		{
			condition = function(self) return self.warnings > 0 end,
			hl = { fg = "bg", bg = "yellow" },
			{
				{
					provider = "",
				},
				{
					provider = function(self) return vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text .. self.warnings end,
				},
				{
					provider = "",
					hl = { bg = "bg", fg = "yellow" },
				},
			},
		},
		-- Hints
		{
			condition = function(self) return self.hints > 0 end,
			hl = { fg = "gray", bg = "bg" },
			{
				{
					provider = function(self)
						local spacer = (self.errors > 0 or self.warnings > 0) and " " or ""
						return spacer .. vim.fn.sign_getdefined("DiagnosticSignHint")[1].text .. self.hints
					end,
				},
			},
		},
		-- Info
		{
			condition = function(self) return self.info > 0 end,
			hl = { fg = "gray", bg = "bg" },
			{
				{
					provider = function(self)
						local spacer = (self.errors > 0 or self.warnings > 0 or self.hints) and " " or ""
						return spacer .. vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text .. self.info
					end,
				},
			},
		},
	}

	---Return the current line number as a % of total lines and the total lines in the file
	local Ruler = {
		condition = function()
			return not conditions.buffer_matches({
				filetype = filetypes,
			})
		end,
		{
			provider = "",
			hl = { fg = "gray", bg = "bg" },
		},
		{
			-- %L = number of lines in the buffer
			-- %P = percentage through file of displayed window
			provider = " %P% /%2L ",
			hl = { fg = "bg", bg = "gray" },
			on_click = {
				callback = function()
					local line = vim.api.nvim_win_get_cursor(0)[1]
					local total_lines = vim.api.nvim_buf_line_count(0)

					if math.floor((line / total_lines)) > 0.5 then
						vim.cmd("normal! gg")
					else
						vim.cmd("normal! G")
					end
				end,
				name = "heirline_ruler",
			},
		},
	}

	local SearchResults = {
		condition = function(self)
			local lines = vim.api.nvim_buf_line_count(0)
			if lines > 50000 then return end

			local query = vim.fn.getreg("/")
			if query == "" then return end

			if query:find("@") then return end

			local search_count = vim.fn.searchcount({ recompute = 1, maxcount = -1 })
			local active = false
			if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then active = true end
			if not active then return end

			query = query:gsub([[^\V]], "")
			query = query:gsub([[\<]], ""):gsub([[\>]], "")

			self.query = query
			self.count = search_count
			return true
		end,
		{
			provider = "",
			hl = function() return { fg = utils.get_highlight("Substitute").bg, bg = "bg" } end,
		},
		{
			provider = function(self)
				return table.concat({
					" ",
					self.count.current,
					"/",
					self.count.total,
					" ",
				})
			end,
			hl = function() return { bg = utils.get_highlight("Substitute").bg, fg = "bg" } end,
		},
		{
			provider = "",
			hl = function() return { bg = utils.get_highlight("Substitute").bg, fg = "bg" } end,
		},
	}

	---Return the status of the current session
	local Session = {
		condition = function(self) return (vim.g.persisting ~= nil) end,
		{
			condition = function()
				return not conditions.buffer_matches({
					filetype = filetypes,
				})
			end,
			RightSlantStart,
			{
				provider = function(self)
					if vim.g.persisting then
						return "   "
					elseif vim.g.persisting == false then
						return "   "
					end
				end,
				hl = { fg = "gray", bg = "statusline_bg" },
				on_click = {
					callback = function() vim.cmd("SessionToggle") end,
					name = "toggle_session",
				},
			},
			RightSlantEnd,
		},
	}

	local Overseer = {
		condition = function()
			local ok, _ = rn.safe_require("overseer")
			if ok then return true end
		end,
		init = function(self)
			self.overseer = require("overseer")
			self.tasks = self.overseer.task_list
			self.STATUS = self.overseer.constants.STATUS
		end,
		static = {
			symbols = {
				["FAILURE"] = "  ",
				["CANCELED"] = "  ",
				["SUCCESS"] = "  ",
				["RUNNING"] = " 省",
			},
			colors = {
				["FAILURE"] = "red",
				["CANCELED"] = "gray",
				["SUCCESS"] = "green",
				["RUNNING"] = "yellow",
			},
		},
		{
			condition = function(self) return #self.tasks.list_tasks() > 0 end,
			{
				provider = function(self)
					local tasks_by_status = self.overseer.util.tbl_group_by(self.tasks.list_tasks({ unique = true }), "status")

					for _, status in ipairs(self.STATUS.values) do
						local status_tasks = tasks_by_status[status]
						if self.symbols[status] and status_tasks then
							self.color = self.colors[status]
							return self.symbols[status]
						end
					end
				end,
				hl = function(self) return { fg = self.color } end,
				on_click = {
					callback = function() require("neotest").run.run_last() end,
					name = "run_last_test",
				},
			},
		},
	}

	local Dap = {
		condition = function()
			local session = require("dap").session()
			return session ~= nil
		end,
		provider = function() return "  " end,
		on_click = {
			callback = function() require("dap").continue() end,
			name = "dap_continue",
		},
		hl = { fg = "red" },
	}

	-- Show plugin updates available from lazy.nvim
	local Lazy = {
		condition = require("lazy.status").has_updates,
		update = { "User", pattern = "LazyUpdate" },
		provider = function() return "  " .. require("lazy.status").updates() .. " " end,
		on_click = {
			callback = function() require("lazy").update() end,
			name = "update_plugins",
		},
		hl = { fg = "gray" },
	}

	--- Return information on the current buffers filetype
	local FileIcon = {
		init = function(self)
			local filename = self.filename
			local extension = vim.fn.fnamemodify(filename, ":e")
			self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
		end,
		provider = function(self) return self.icon and (" " .. self.icon .. " ") end,
		on_click = {
			callback = function() rn.ChangeFiletype() end,
			name = "change_ft",
		},
		hl = { fg = "gray", bg = "statusline_bg" },
	}

	local FileType = {
		provider = function() return string.lower(vim.bo.filetype) .. " " end,
		on_click = {
			callback = function() rn.ChangeFiletype() end,
			name = "change_ft",
		},
		hl = { fg = "gray", bg = "statusline_bg" },
	}

	FileType = utils.insert(FileBlock, RightSlantStart, FileIcon, FileType, RightSlantEnd)

	--- Return information on the current file's encoding
	local FileEncoding = {
		condition = function()
			return not conditions.buffer_matches({
				filetype = filetypes,
			})
		end,
		RightSlantStart,
		{
			provider = function()
				local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
				return " " .. enc .. " "
			end,
			hl = {
				fg = "gray",
				bg = "statusline_bg",
			},
		},
		RightSlantEnd,
	}

	---The statusline component
	return {
		condition = function()
			return not conditions.buffer_matches({
				filetype = force_inactive_filetypes,
			})
		end,

		-- Left
		VimMode,
		GitBranch,
		FileNameBlock,
		LspDiagnostics,

		-- Right
		Align,
		Overseer,
		Dap,
		Lazy,
		FileType,
		FileEncoding,
		Session,
		SearchResults,
		Ruler,
	}
end

---Load the bufferline, tabline and statusline. Extracting this to a seperate
---function allows us to call it from autocmds and preserve colors
function M.load()
	local heirline = require("heirline")

	heirline.load_colors(require("onedarkpro.helpers").get_colors())
	heirline.setup(statusline(), nil, bufferline())

	vim.o.showtabline = 2
	vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
end

---Used by Lazy to load the statusline
function M.config()
	M.load()
end

return M
