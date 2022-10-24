-- @module utils.statusline.utils
-- A collection of miscellaneous helper functions
-- Credit to AstroNvim
local M = {}

local general_utils = require("utils.general")
local st_misc = require("utils.statusline.misc")

local function is_valid_buffer(bufnr)
  if not bufnr or bufnr < 1 then
    return false
  end
  return vim.bo[bufnr].buflisted and vim.api.nvim_buf_is_valid(bufnr)
end

local function insert(destination, ...)
  local new = general_utils.default_tbl({}, destination)
  for _, child in ipairs({ ... }) do
    table.insert(new, general_utils.default_tbl({}, child))
  end
  return new
end

--- A utility function to stylize a string with an icon from lspkind, separators, and left/right padding
-- @param str the string to stylize
-- @param opts options of `{ padding = { left = 0, right = 0 }, separator = { left = "|", right = "|" }, show_empty = false, icon = { kind = "NONE", padding = { left = 0, right = 0 } } }`
-- @return the stylized string
-- @usage local string = require("utils.statusline.utils").stylize("Hello", { padding = { left = 1, right = 1 }, icon = { kind = "ICON_NAME" } })
function M.stylize(str, opts)
  opts = general_utils.default_tbl(opts, {
    padding = { left = 0, right = 0 },
    separator = { left = "", right = "" },
    show_empty = false,
    icon = { kind = "NONE", padding = { left = 0, right = 0 } },
  })

  local icon = general_utils.pad_string(
    require("const.ICON").STATUSLINE[opts.icon.kind],
    opts.icon.padding
  )
  return str
      and (str ~= "" or opts.show_empty)
      and opts.separator.left .. general_utils.pad_string(
        icon .. str,
        opts.padding
      ) .. opts.separator.right
    or ""
end

--- Surround component with separator and color adjustment
-- @param separator the separator index to use in `utils.statusline.misc.separators`
-- @param color the color to use as the separator foreground/component background
-- @param component the component to surround
-- @param condition the condition for displaying the surrounded component
-- @return the new surrounded component
function M.surround(separator, color, component, condition)
  local function surround_color(self)
    local colors = type(color) == "function" and color(self) or color
    return type(colors) == "string" and { main = colors } or colors
  end

  separator = type(separator) == "string" and st_misc.separators[separator]
    or separator
  local surrounded = { condition = condition }
  if separator[1] ~= "" then
    table.insert(surrounded, {
      provider = separator[1],
      hl = function(self)
        local s_color = surround_color(self)
        if s_color then
          return { fg = s_color.main, bg = s_color.left }
        end
      end,
    })
  end
  table.insert(surrounded, {
    hl = function(self)
      local s_color = surround_color(self)
      if s_color then
        return { bg = s_color.main }
      end
    end,
    general_utils.default_tbl({}, component),
  })
  if separator[2] ~= "" then
    table.insert(surrounded, {
      provider = separator[2],
      hl = function(self)
        local s_color = surround_color(self)
        if s_color then
          return { fg = s_color.main, bg = s_color.right }
        end
      end,
    })
  end
  return surrounded
end

function M.get_valid_buffers()
  return vim.tbl_filter(is_valid_buffer, vim.api.nvim_list_bufs())
end

--- Create a flexible statusline component
-- @param priority the priority of the element
-- @return the flexible component that switches between components to fit the width
function M.make_flexible(priority, ...)
  local new = insert({}, ...)
  new.static = { _priority = priority }
  new.init = function(self)
    if not vim.tbl_contains(self._flexible_components, self) then
      table.insert(self._flexible_components, self)
    end
    self:set_win_attr("_win_child_index", nil, 1)
    self.pick_child = { self:get_win_attr("_win_child_index") }
  end
  new.restrict = { _win_child_index = true }
  return new
end

--- A utility function to get the width of the bar
-- @param is_winbar boolean true if you want the width of the winbar, false if you want the statusline width
-- @return the width of the specified bar
function M.width(is_winbar)
  return vim.o.laststatus == 3 and not is_winbar and vim.o.columns
    or vim.api.nvim_win_get_width(0)
end

return M
