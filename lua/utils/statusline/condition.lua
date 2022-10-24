-- @module utils.statusline.condition
-- A collection of methods that can be use as Heirline conditions for controlling when components are enabled
-- Credit to AstroNvim
local M = {}

--- A condition function if the buffer filetype,buftype,bufname match a pattern
-- @return boolean of wether or not LSP is attached
-- @usage local heirline_component = { provider = "Example Provider", condition = function() return require("utils.statusline.condition").buffer_matches { buftype = { "terminal" } } end }
function M.buffer_matches(patterns)
  for kind, pattern_list in pairs(patterns) do
    if require("utils.statusline.misc").buf_matchers[kind](pattern_list) then
      return true
    end
  end
  return false
end

--- A condition function if there is a defined filetype
-- @return boolean of wether or not there is a filetype
-- @usage local heirline_component = { provider = "Example Provider", condition = require("utils.statusline.condition").has_filetype }
function M.has_filetype()
  return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    and vim.bo.filetype
    and vim.bo.filetype ~= ""
end

--- A condition function if the current buffer is modified
-- @return boolean of wether or not the current buffer is modified
-- @usage local heirline_component = { provider = "Example Provider", condition = require("utils.statusline.condition").file_modified }
function M.file_modified(bufnr)
  return vim.bo[bufnr or 0].modified
end

--- A condition function if the current buffer is read only
-- @return boolean of wether or not the current buffer is read only or not modifiable
-- @usage local heirline_component = { provider = "Example Provider", condition = require("utils.statusline.condition").file_read_only }
function M.file_read_only(bufnr)
  local buffer = vim.bo[bufnr or 0]
  return not buffer.modifiable or buffer.readonly
end

--- A condition function if the current file is in a git repo
-- @return boolean of wether or not the current file is in a git repo
-- @usage local heirline_component = { provider = "Example Provider", condition = require("utils.statusline.condition").is_git_repo }
function M.is_git_repo()
  return vim.b.gitsigns_head or vim.b.gitsigns_status_dict
end

function M.git_changed()
  local git_status = vim.b.gitsigns_status_dict
  return git_status
    and (git_status.added or 0)
        + (git_status.removed or 0)
        + (git_status.changed or 0)
      > 0
end

--- A condition function if the current file has any diagnostics
-- @return boolean of wether or not the current file has any diagnostics
-- @usage local heirline_component = { provider = "Example Provider", condition = require("utils.statusline.condition").has_diagnostics }
function M.has_diagnostics()
  return vim.g.status_diagnostics_enabled and #vim.diagnostic.get(0) > 0
end

--- A condition function if LSP is attached
-- @return boolean of wether or not LSP is attached
-- @usage local heirline_component = { provider = "Example Provider", condition = require("utils.statusline.condition").lsp_attached }
function M.lsp_attached()
  return next(vim.lsp.buf_get_clients()) ~= nil
end

return M
