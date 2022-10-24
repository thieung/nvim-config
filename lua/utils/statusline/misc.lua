-- @module utils.statusline.misc
-- Store globally accessible variables such as separators, mode text, etc.
-- Credit to AstroNvim
local M = {}

local function pattern_match(str, pattern_list)
  for _, pattern in ipairs(pattern_list) do
    if str:find(pattern) then
      return true
    end
  end
  return false
end

M.modes = {
  ["n"] = { "NORMAL", "normal" },
  ["no"] = { "OP", "normal" },
  ["nov"] = { "OP", "normal" },
  ["noV"] = { "OP", "normal" },
  ["no"] = { "OP", "normal" },
  ["niI"] = { "NORMAL", "normal" },
  ["niR"] = { "NORMAL", "normal" },
  ["niV"] = { "NORMAL", "normal" },
  ["i"] = { "INSERT", "insert" },
  ["ic"] = { "INSERT", "insert" },
  ["ix"] = { "INSERT", "insert" },
  ["t"] = { "TERM", "insert" },
  ["nt"] = { "TERM", "insert" },
  ["v"] = { "VISUAL", "visual" },
  ["vs"] = { "VISUAL", "visual" },
  ["V"] = { "LINES", "visual" },
  ["Vs"] = { "LINES", "visual" },
  [""] = { "BLOCK", "visual" },
  ["s"] = { "BLOCK", "visual" },
  ["R"] = { "REPLACE", "replace" },
  ["Rc"] = { "REPLACE", "replace" },
  ["Rx"] = { "REPLACE", "replace" },
  ["Rv"] = { "V-REPLACE", "replace" },
  ["s"] = { "SELECT", "visual" },
  ["S"] = { "SELECT", "visual" },
  [""] = { "BLOCK", "visual" },
  ["c"] = { "COMMAND", "command" },
  ["cv"] = { "COMMAND", "command" },
  ["ce"] = { "COMMAND", "command" },
  ["r"] = { "PROMPT", "inactive" },
  ["rm"] = { "MORE", "inactive" },
  ["r?"] = { "CONFIRM", "inactive" },
  ["!"] = { "SHELL", "inactive" },
  ["null"] = { "null", "inactive" },
}

M.separators = {
  none = { "", "" },
  left = { "", " " },
  right = { " ", "" },
  center = { "  ", "  " },
  tab = { "", "" },
}

M.buf_matchers = {
  filetype = function(pattern_list)
    return pattern_match(vim.bo.filetype, pattern_list)
  end,
  buftype = function(pattern_list)
    return pattern_match(vim.bo.buftype, pattern_list)
  end,
  bufname = function(pattern_list)
    return pattern_match(
      vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t"),
      pattern_list
    )
  end,
}

function M.update_events(opts)
  return function(self)
    if not rawget(self, "once") then
      local clear_cache = function()
        self._win_cache = nil
      end
      for _, event in ipairs(opts) do
        local event_opts = { callback = clear_cache }
        if type(event) == "table" then
          event_opts.pattern = event.pattern
          event_opts.callback = event.callback or clear_cache
          event.pattern = nil
          event.callback = nil
        end
        vim.api.nvim_create_autocmd(event, event_opts)
      end
      self.once = true
    end
  end
end

return M
