local M = {}

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

function M.default_tbl(opts, default)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
end

--- Add left and/or right padding to a string
-- @param str the string to add padding to
-- @param padding a table of the format `{ left = 0, right = 0}` that defines the number of spaces to include to the left and the right of the string
-- @return the padded string
function M.pad_string(str, padding)
  padding = padding or {}
  return str
      and str ~= ""
      and string.rep(" ", padding.left or 0) .. str .. string.rep(
        " ",
        padding.right or 0
      )
    or ""
end

--- Get a list of registered null-ls providers for a given filetype
-- @param filetype the filetype to search null-ls for
-- @return a list of null-ls sources
function M.null_ls_providers(filetype)
  local registered = {}
  -- try to load null-ls
  local sources_avail, sources = pcall(require, "null-ls.sources")
  if sources_avail then
    -- get the available sources of a given filetype
    for _, source in ipairs(sources.get_available(filetype)) do
      -- get each source name
      for method in pairs(source.methods) do
        registered[method] = registered[method] or {}
        table.insert(registered[method], source.name)
      end
    end
  end
  -- return the found null-ls sources
  return registered
end

--- Get the null-ls sources for a given null-ls method
-- @param filetype the filetype to search null-ls for
-- @param method the null-ls method (check null-ls documentation for available methods)
-- @return the available sources for the given filetype and method
function M.null_ls_sources(filetype, method)
  local methods_avail, methods = pcall(require, "null-ls.methods")
  return methods_avail
      and M.null_ls_providers(filetype)[methods.internal[method]]
    or {}
end

return M
