local ok, gitc = pcall(require, "git-conflict")
local gitrepo = vim.fn.isdirectory(".git/index")

if not ok or not gitrepo then
  return
end

gitc.setup({
  default_mappings = false,
  disable_diagnostics = true,
  highlights = {
    current = "DiffText",
    incoming = "DiffAdd",
    ancester = "DiffDelete",
  },
})
