-- @module utils.statusline.provider
-- A collection of methods that can be set as Heirline providers
-- Credit to AstroNvim
local M = {}

local general_utils = require("utils.general")
local st_misc = require("utils.statusline.misc")
local st_utils = require("utils.statusline.utils")
local st_condition = require("utils.statusline.condition")

--- A provider function for the fill string
-- @return the statusline string for empty
-- @usage local heirline_component = { provider = require("utils.statusline.provider").empty }
function M.empty()
  return ""
end

--- A provider function for the fill string
-- @return the statusline string for spacing
-- @usage local heirline_component = { provider = require("utils.statusline.provider").space }
function M.space(n)
  return string.rep(" ", n or 1)
end

--- A provider function for the fill string
-- @return the statusline string for alignment
-- @usage local heirline_component = { provider = require("utils.statusline.provider").align }
function M.align()
  return "%="
end

--- A provider function for showing the text of the current vim mode
-- @param opts options for padding the text and options passed to the stylize function
-- @return the function for displaying the text of the current vim mode
-- @usage local heirline_component = { provider = require("utils.statusline.provider").mode_text() }
-- @see require("utils.statusline.utils").stylize
function M.mode_text(opts)
  local max_length = math.max(unpack(vim.tbl_map(function(str)
    return #str[1]
  end, vim.tbl_values(st_misc.modes))))
  return function()
    local text = st_misc.modes[vim.fn.mode()][1]
    if opts.pad_text then
      local padding = max_length - #text
      if opts.pad_text == "right" then
        text = string.rep(" ", padding) .. text
      elseif opts.pad_text == "left" then
        text = text .. string.rep(" ", padding)
      elseif opts.pad_text == "center" then
        text = string.rep(" ", math.floor(padding / 2))
          .. text
          .. string.rep(" ", math.ceil(padding / 2))
      end
    end
    return st_utils.stylize(text, opts)
  end
end

--- A provider function for displaying a single string
-- @param opts options passed to the stylize function
-- @usage local heirline_component = { provider = require("utils.statusline.provider").str({ str = "Hello" }) }
-- @see utils.statusline.utils.stylize
function M.str(opts)
  -- @return the stylized statusline string
  opts = general_utils.default_tbl(opts, { str = " " })
  return st_utils.stylize(opts.str, opts)
end

--- A provider function for showing if spellcheck is on
-- @param opts options passed to the stylize function
-- @return the function for outputting if spell is enabled
-- @usage local heirline_component = { provider = require("utils.statusline.provider").spell() }
-- @see require("utils.statusline.utils").stylize
function M.spell(opts)
  opts = general_utils.default_tbl(
    opts,
    { str = "", icon = { kind = "SPELLCHECK" }, show_empty = true }
  )
  return function()
    return st_utils.stylize(vim.wo.spell and opts.str, opts)
  end
end

--- A provider function for showing if paste is enabled
-- @param opts options passed to the stylize function
-- @return the function for outputting if paste is enabled
-- @usage local heirline_component = { provider = require("utils.statusline.provider").paste() }
-- @see require("utils.statusline.utils").stylize
function M.paste(opts)
  opts = general_utils.default_tbl(
    opts,
    { str = "", icon = { kind = "PASTE" }, show_empty = true }
  )
  return function()
    return st_utils.stylize(vim.opt.paste:get() and opts.str, opts)
  end
end

--- A provider function for showing the current filetype icon
-- @param opts options passed to the stylize function
-- @return the function for outputting the filetype icon
-- @usage local heirline_component = { provider = require("utils.statusline.provider").file_icon() }
-- @see utils.statusline.utils.stylize
function M.file_icon(opts)
  return function(self)
    local ft_icon, _ = require("nvim-web-devicons").get_icon(
      vim.fn.fnamemodify(
        vim.api.nvim_buf_get_name(self and self.bufnr or 0),
        ":t"
      ),
      nil,
      { default = true }
    )
    return st_utils.stylize(ft_icon, opts)
  end
end

--- A provider function for showing the current filename
-- @param opts options for argument to fnamemodify to format filename and options passed to the stylize function
-- @return the function for outputting the filename
-- @usage local heirline_component = { provider = require("utils.statusline.provider").filename() }
-- @see utils.statusline.utils.stylize
function M.filename(opts)
  opts = general_utils.default_tbl(opts, {
    fname = function(nr)
      return vim.api.nvim_buf_get_name(nr)
    end,
    modify = ":t",
  })
  return function(self)
    local filename =
      vim.fn.fnamemodify(opts.fname(self and self.bufnr or 0), opts.modify)
    return st_utils.stylize((filename == "" and "[No Name]" or filename), opts)
  end
end

--- A provider function for showing if the current file is modifiable
-- @param opts options passed to the stylize function
-- @return the function for outputting the indicator if the file is modified
-- @usage local heirline_component = { provider = require("utils.statusline.provider").file_modified() }
-- @see utils.statusline.utils.stylize
function M.file_modified(opts)
  opts = general_utils.default_tbl(opts, {
    str = "",
    icon = { kind = "FILE_MODIFIED" },
    show_empty = true,
  })
  return function(self)
    return st_utils.stylize(
      st_condition.file_modified((self or {}).bufnr) and opts.str,
      opts
    )
  end
end

--- A provider function for showing if the current file is read-only
-- @param opts options passed to the stylize function
-- @return the function for outputting the indicator if the file is read-only
-- @usage local heirline_component = { provider = require("utils.statusline.provider").file_read_only() }
-- @see utils.statusline.utils.stylize
function M.file_read_only(opts)
  opts = general_utils.default_tbl(opts, {
    str = "",
    icon = { kind = "FILE_READONLY" },
    show_empty = true,
  })
  return function(self)
    return st_utils.stylize(
      st_condition.file_read_only((self or {}).bufnr) and opts.str,
      opts
    )
  end
end

--- A provider function for showing the current filetype
-- @param opts options passed to the stylize function
-- @return the function for outputting the filetype
-- @usage local heirline_component = { provider = require("utils.statusline.provider").filetype() }
-- @see utils.statusline.utils.stylize
function M.filetype(opts)
  return function(self)
    local buffer = vim.bo[self and self.bufnr or 0]
    return st_utils.stylize(string.lower(buffer.filetype), opts)
  end
end

--- Get a unique filepath between all buffers
-- @param opts options for function to get the buffer name, a buffer number, max length, and options passed to the stylize function
-- @return path to file that uniquely identifies each buffer
-- @usage local heirline_component = { provider = require("utils.statusline.provider").unique_path() }
-- @see utils.statusline.utils.stylize
function M.unique_path(opts)
  opts = general_utils.default_tbl(opts, {
    buf_name = function(bufnr)
      return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
    end,
    bufnr = 0,
    max_length = 16,
  })
  return function(self)
    opts.bufnr = self and self.bufnr or opts.bufnr
    local name = opts.buf_name(opts.bufnr)
    local unique_path = ""
    -- check for same buffer names under different dirs
    for _, value in ipairs(st_utils.get_valid_buffers()) do
      if name == opts.buf_name(value) and value ~= opts.bufnr then
        local other = {}
        for match in
          (vim.api.nvim_buf_get_name(value) .. "/"):gmatch("(.-)" .. "/")
        do
          table.insert(other, match)
        end

        local current = {}
        for match in
          (vim.api.nvim_buf_get_name(opts.bufnr) .. "/"):gmatch("(.-)" .. "/")
        do
          table.insert(current, match)
        end

        unique_path = ""

        for i = #current - 1, 1, -1 do
          local value_current = current[i]
          local other_current = other[i]

          if value_current ~= other_current then
            unique_path = value_current .. "/"
            break
          end
        end
        break
      end
    end
    return st_utils.stylize(
      (
        opts.max_length > 0
        and #unique_path > opts.max_length
        and string.sub(unique_path, 1, opts.max_length - 2)
          .. require("const.ICON").STATUSLINE.ELLIPSIS
          .. "/"
      ) or unique_path,
      opts
    )
  end
end

--- A provider function for showing the current git branch
-- @param opts options passed to the stylize function
-- @return the function for outputting the git branch
-- @usage local heirline_component = { provider = require("utils.statusline.provider").git_branch() }
-- @see utils.statusline.utils.stylize
function M.git_branch(opts)
  return function(self)
    return st_utils.stylize(
      vim.b[self and self.bufnr or 0].gitsigns_head or "",
      opts
    )
  end
end

--- A provider function for showing the current git diff count of a specific type
-- @param opts options for type of git diff and options passed to the stylize function
-- @return the function for outputting the git diff
-- @usage local heirline_component = { provider = require("utils.statusline.provider").git_diff({ type = "added" }) }
-- @see utils.statusline.utils.stylize
function M.git_diff(opts)
  if not opts or not opts.type then
    return
  end
  return function(self)
    local status = vim.b[self and self.bufnr or 0].gitsigns_status_dict
    return st_utils.stylize(
      status
          and status[opts.type]
          and status[opts.type] > 0
          and tostring(status[opts.type])
        or "",
      opts
    )
  end
end

--- A provider function for showing the current diagnostic count of a specific severity
-- @param opts options for severity of diagnostic and options passed to the stylize function
-- @return the function for outputting the diagnostic count
-- @usage local heirline_component = { provider = require("utils.statusline.provider").diagnostics({ severity = "ERROR" }) }
-- @see utils.statusline.utils.stylize
function M.diagnostics(opts)
  if not opts or not opts.severity then
    return
  end
  return function(self)
    local bufnr = self and self.bufnr or 0
    local count = #vim.diagnostic.get(
      bufnr,
      opts.severity and { severity = vim.diagnostic.severity[opts.severity] }
    )
    return st_utils.stylize(count ~= 0 and tostring(count) or "", opts)
  end
end

function M.lsp_client_names(opts)
  opts =
    general_utils.default_tbl(opts, { expand_null_ls = false, truncate = 0.25 })
  return function(self)
    local buf_client_names = {}
    for _, client in
      pairs(vim.lsp.get_active_clients({ bufnr = self and self.bufnr or 0 }))
    do
      if client.name == "null-ls" and opts.expand_null_ls then
        local null_ls_sources = {}
        for _, type in ipairs({ "FORMATTING", "DIAGNOSTICS" }) do
          for _, source in
            ipairs(general_utils.null_ls_sources(vim.bo.filetype, type))
          do
            null_ls_sources[source] = true
          end
        end
        vim.list_extend(buf_client_names, vim.tbl_keys(null_ls_sources))
      else
        table.insert(buf_client_names, client.name)
      end
    end
    local str = table.concat(buf_client_names, ", ")
    if type(opts.truncate) == "number" then
      local max_width = math.floor(st_utils.width() * opts.truncate)
      if #str > max_width then
        str = string.sub(str, 0, max_width) .. "…"
      end
    end
    return st_utils.stylize(str, opts)
  end
end

--- A provider function for showing the current line and character in a document
-- @param opts options for padding the line and character locations and options passed to the stylize function
-- @return the statusline string for showing location in document line_num:char_num
-- @usage local heirline_component = { provider = require("utils.statusline.provider").ruler({ pad_ruler = { line = 3, char = 2 } }) }
-- @see utils.statusline.utils.stylize
function M.ruler(opts)
  opts = general_utils.default_tbl(opts, { pad_ruler = { line = 0, char = 0 } })
  return st_utils.stylize(
    string.format("%%%dl:%%%dc", opts.pad_ruler.line, opts.pad_ruler.char),
    opts
  )
end

--- A provider function for showing the percentage of the current location in a document
-- @param opts options passed to the stylize function
-- @return the statusline string for displaying the percentage of current document location
-- @usage local heirline_component = { provider = require("utils.statusline.provider").percentage() }
-- @see utils.statusline.utils.stylize
function M.percentage(opts)
  return function()
    local text = "%p%%"
    local current_line = vim.fn.line(".")
    if current_line == 1 then
      text = "Top"
    elseif current_line == vim.fn.line("$") then
      text = "Bot"
    end
    return st_utils.stylize(text, opts)
  end
end

--- A provider function for showing the current location as a scrollbar
-- @param opts options passed to the stylize function
-- @return the function for outputting the scrollbar
-- @usage local heirline_component = { provider = require("utils.statusline.provider").scrollbar() }
-- @see utils.statusline.utils.stylize
function M.scrollbar(opts)
  local sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
  return function()
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor((curr_line - 1) / lines * #sbar) + 1
    return st_utils.stylize(string.rep(sbar[i], 2), opts)
  end
end

--- A condition function if treesitter is in use
-- @return boolean of wether or not treesitter is active
-- @usage local heirline_component = { provider = "Example Provider", condition = require("utils.statusline.condition").treesitter_available }
function M.treesitter_available()
  local ts_avail, ts = pcall(require, "nvim-treesitter.parsers")
  return ts_avail and ts.has_parser()
end

return M
