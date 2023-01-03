---check if a certain feature/version/commit exists in nvim
---@param feature string
---@return boolean
function rn.has(feature)
  return vim.fn.has(feature) > 0
end

rn.nightly = rn.has("nvim-0.9")

---Require a module using `pcall` and report any errors if have
---@param module string
---@param opts table?
---@return boolean, any
function rn.safe_require(module, opts)
  opts = opts or { silent = false }
  local ok, result = pcall(require, module)
  if not ok and not opts.silent then
    vim.notify(
      result,
      vim.log.levels.ERROR,
      { title = string.format("Error requiring: %s", module) }
    )
  end
  return ok, result
end
