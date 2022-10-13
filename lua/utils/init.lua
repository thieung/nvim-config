local M = {}

M.Augroup = require("utils.augroup")
M.Command = require("utils.command")
M.Keymap = require("utils.keymap")
M.Highlight = require("utils.highlight")

function M.reload_modules(module_name, starts_with_only)
  -- Default to starts with only
  if starts_with_only == nil then
    starts_with_only = true
  end

  local matcher
  if not starts_with_only then
    matcher = function(pack)
      return string.find(pack, module_name, 1, true)
    end
  else
    local module_name_pattern = vim.pesc(module_name)
    matcher = function(pack)
      return string.find(pack, "^" .. module_name_pattern)
    end
  end

  for pack, _ in pairs(package.loaded) do
    if matcher(pack) then
      package.loaded[pack] = nil
    end
  end
end

return M
