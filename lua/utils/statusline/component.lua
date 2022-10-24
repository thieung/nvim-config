-- @module utils.statusline.component
-- A collection of methods to assist in building entire components. This is the main piece to interact with when building custom statuslines
-- Credit to AstroNvim
local M = {}

local general_utils = require("utils.general")
local st_utils = require("utils.statusline.utils")
local st_provider = require("utils.statusline.provider")
local st_condition = require("utils.statusline.condition")
local st_hl = require("utils.statusline.hl")
local st_misc = require("utils.statusline.misc")

function M.align()
  return { provider = st_provider.align() }
end

function M.space(n)
  return { provider = st_provider.space(n) }
end

--- A general function to build a section of status providers with highlights, conditions, and section surrounding
-- @param opts a list of components to build into a section
-- @return The Heirline component table
-- @usage local heirline_component = require("utils.statusline.component").builder({ { provider = "file_icon", opts = { padding = { right = 1 } } }, { provider = "filename" } })
function M.builder(opts)
  opts = general_utils.default_tbl(opts, { padding = { left = 0, right = 0 } })
  local children = {}
  if opts.padding.left > 0 then -- add left padding
    table.insert(children, {
      provider = general_utils.pad_string(
        " ",
        { left = opts.padding.left - 1 }
      ),
    })
  end
  for key, entry in pairs(opts) do
    if
      type(key) == "number"
      and type(entry) == "table"
      and st_provider[entry.provider]
      and (entry.opts == nil or type(entry.opts) == "table")
    then
      entry.provider = st_provider[entry.provider](entry.opts)
    end
    children[key] = entry
  end
  if opts.padding.right > 0 then -- add right padding
    table.insert(children, {
      provider = general_utils.pad_string(
        " ",
        { right = opts.padding.right - 1 }
      ),
    })
  end
  return opts.surround
      and st_utils.surround(
        opts.surround.separator,
        opts.surround.color,
        children,
        opts.surround.condition
      )
    or children
end

--- A function to build a set of children components for a mode section
-- @param opts options for configuring mode text and the overall padding
-- @return The Heirline component table
-- @usage local heirline_component = require("utils.statusline.component").mode { mode_text = true }
function M.mode(opts)
  opts = general_utils.default_tbl(opts, {
    mode_text = false,
    surround = {
      separator = "left",
      color = require("utils.statusline.hl").mode_bg,
    },
    hl = { fg = "bg" },
    update = "ModeChanged",
  })

  for i, key in ipairs({ "mode_text", "paste", "spell" }) do
    if key == "mode_text" and not opts[key] then
      opts[i] = { provider = "str", opts = { str = " " } }
    else
      opts[i] = opts[key]
          and { provider = key, opts = opts[key], hl = opts[key].hl }
        or false
    end
  end
  return M.builder(opts)
end

--- A function to build a set of children components for an entire file information section
-- @param opts options for configuring file_icon, filename, filetype, file_modified, file_read_only, and the overall padding
-- @return The Heirline component table
-- @usage local heirline_component = require("utils.statusline.component").file_info()
function M.file_info(opts)
  opts = general_utils.default_tbl(opts, {
    file_icon = { highlight = true, padding = { left = 1, right = 1 } },
    filename = {},
    file_modified = { padding = { left = 1 } },
    file_read_only = { padding = { left = 1 } },
    surround = {
      separator = "left",
      color = "file_info_bg",
      condition = st_condition.has_filetype,
    },
    hl = { fg = "file_info_fg" },
  })
  for i, key in ipairs({
    "file_icon",
    "unique_path",
    "filename",
    "filetype",
    "file_modified",
    "file_read_only",
  }) do
    opts[i] = opts[key]
        and {
          provider = key,
          opts = opts[key],
          hl = opts[key].highlight and st_hl.filetype_color or opts[key].hl,
          on_click = opts[key].on_click,
        }
      or false
  end
  return M.builder(opts)
end

function M.git_branch(opts)
  opts = general_utils.default_tbl(opts, {
    git_branch = { icon = { kind = "GIT_BRANCH", padding = { right = 1 } } },
    surround = {
      separator = "left",
      color = "git_branch_bg",
      condition = st_condition.is_git_repo,
    },
    hl = { fg = "git_branch_fg", bold = true },
    on_click = {
      name = "heirline_branch",
      callback = function()
        vim.defer_fn(function()
          require("telescope.builtin").git_branches()
        end, 100)
      end,
    },
    update = { "User", pattern = "GitSignsUpdate" },
    init = st_misc.update_events({ "BufEnter" }),
  })
  opts[1] = opts.git_branch
      and { provider = "git_branch", opts = opts.git_branch }
    or false
  return M.builder(opts)
end

function M.git_diff(opts)
  opts = general_utils.default_tbl(opts, {
    added = { icon = { kind = "GIT_ADD", padding = { left = 1, right = 1 } } },
    changed = {
      icon = { kind = "GIT_CHANGE", padding = { left = 1, right = 1 } },
    },
    removed = {
      icon = { kind = "GIT_DELETE", padding = { left = 1, right = 1 } },
    },
    hl = { fg = "git_diff_fg", bold = true },
    on_click = {
      name = "heirline_git",
      callback = function()
        vim.defer_fn(function()
          require("telescope.builtin").git_status()
        end, 100)
      end,
    },
    surround = {
      separator = "left",
      color = "git_diff_bg",
      condition = st_condition.git_changed,
    },
    update = { "User", pattern = "GitSignsUpdate" },
    init = st_misc.update_events({ "BufEnter" }),
  })
  for i, kind in ipairs({ "added", "changed", "removed" }) do
    if type(opts[kind]) == "table" then
      opts[kind].type = kind
    end
    opts[i] = opts[kind]
        and {
          provider = "git_diff",
          opts = opts[kind],
          hl = { fg = "git_" .. kind },
        }
      or false
  end
  return M.builder(opts)
end

--- A function to build a set of children components for a diagnostics section
-- @param opts options for configuring diagnostic providers and the overall padding
-- @return The Heirline component table
-- @usage local heirline_component = require("utils.statusline.component").diagnostics()
function M.diagnostics(opts)
  opts = general_utils.default_tbl(opts, {
    ERROR = {
      icon = { kind = "DIAG_ERROR", padding = { left = 1, right = 1 } },
    },
    WARN = {
      icon = { kind = "DIAG_WARN", padding = { left = 1, right = 1 } },
    },
    INFO = {
      icon = { kind = "DIAG_INFO", padding = { left = 1, right = 1 } },
    },
    HINT = {
      icon = { kind = "DIAG_HINT", padding = { left = 1, right = 1 } },
    },
    surround = {
      separator = "left",
      color = "diagnostics_bg",
      condition = st_condition.has_diagnostics,
    },
    hl = { fg = "diagnostics_fg" },
    on_click = {
      name = "heirline_diagnostic",
      callback = function()
        vim.defer_fn(function()
          require("telescope.builtin").diagnostics()
        end, 100)
      end,
    },
    update = { "DiagnosticChanged", "BufEnter" },
  })
  for i, kind in ipairs({ "ERROR", "WARN", "INFO", "HINT" }) do
    if type(opts[kind]) == "table" then
      opts[kind].severity = kind
    end
    opts[i] = opts[kind]
        and {
          provider = "diagnostics",
          opts = opts[kind],
          hl = { fg = "diag_" .. string.lower(kind) },
        }
      or false
  end
  return M.builder(opts)
end

--- A function to build a set of children components for an LSP section
-- @param opts options for configuring lsp progress and client_name providers and the overall padding
-- @return The Heirline component table
-- @usage local heirline_component = require("utils.statusline.component").lsp()
function M.lsp(opts)
  opts = general_utils.default_tbl(opts, {
    lsp_client_names = {
      str = "LSP",
      icon = { kind = "ACTIVE_LSP", padding = { right = 2 } },
    },
    hl = { fg = "lsp_fg" },
    surround = {
      separator = "right",
      color = "lsp_bg",
      condition = st_condition.lsp_attached,
    },
    on_click = {
      name = "heirline_lsp",
      callback = function()
        vim.defer_fn(function()
          vim.cmd("LspInfo")
        end, 100)
      end,
    },
  })
  opts[1] = {}
  local provider = "lsp_client_names"
  if type(opts[provider]) == "table" then
    local new_provider = opts[provider].str
        and st_utils.make_flexible(
          1,
          { provider = st_provider[provider](opts[provider]) },
          { provider = st_provider.str(opts[provider]) }
        )
      or { provider = provider, opts = opts[provider] }
    new_provider.update = { "LspAttach", "LspDetach", "BufEnter" }
    table.insert(opts[1], new_provider)
  end
  return M.builder(opts)
end

--- A function to build a set of children components for an entire navigation section
-- @param opts options for configuring ruler, percentage, scrollbar, and the overall padding
-- @return The Heirline component table
-- @usage local heirline_component = require("utils.statusline.component").nav()
function M.nav(opts)
  opts = general_utils.default_tbl(opts, {
    ruler = {},
    percentage = { padding = { left = 1 } },
    scrollbar = { padding = { left = 1 }, hl = { fg = "scrollbar" } },
    surround = { separator = "right", color = "nav_bg" },
    hl = { fg = "nav_fg" },
    update = { "CursorMoved", "BufEnter" },
  })

  for i, key in ipairs({ "ruler", "percentage", "scrollbar" }) do
    opts[i] = opts[key]
        and { provider = key, opts = opts[key], hl = opts[key].hl }
      or false
  end

  return M.builder(opts)
end

--- A function to build a set of children components for a Treesitter section
-- @param opts options for configuring diagnostic providers and the overall padding
-- @return The Heirline component table
-- @usage local heirline_component = require("utils.statusline.component").treesitter()
function M.treesitter(opts)
  opts = general_utils.default_tbl(opts, {
    str = { str = "TS", icon = { kind = "ACTIVE_TS" } },
    surround = {
      separator = "right",
      color = "treesitter_bg",
      condition = st_condition.treesitter_available,
    },
    hl = { fg = "treesitter_fg" },
    update = { "OptionSet", pattern = "syntax" },
    init = st_misc.update_events({ "BufEnter" }),
  })
  opts[1] = opts.str and { provider = "str", opts = opts.str } or false
  return M.builder(opts)
end

return M
