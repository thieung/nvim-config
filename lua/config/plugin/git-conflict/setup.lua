local ok, gitc = pcall(require, "git-conflict")
if not ok then
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
