-- @module utils.statusline.hl
-- Collection of methods to assist in setting the color of a component
-- Credit to AstroNvim
local M = {}
local devicons_avail, devicons = pcall(require, "nvim-web-devicons")

function M.mode()
  return { bg = M.mode_bg() }
end

function M.mode_bg()
  return require("utils.statusline.misc").modes[vim.fn.mode()][2]
end

--- Get the foreground color group for the current filetype
-- @return the highlight group for the current filetype foreground
-- @usage local heirline_component = { provider = require("utils.statusline.provider").fileicon(), hl = require("utils.statusline.hl").filetype_color },
function M.filetype_color(self)
  if not devicons_avail then
    return {}
  end
  local _, color = devicons.get_icon_color(
    vim.fn.fnamemodify(
      vim.api.nvim_buf_get_name(self and self.bufnr or 0),
      ":t"
    ),
    nil,
    { default = true }
  )
  return { fg = color }
end

return M
