local filename = {
  [".env"] = "config",
  [".envrc"] = "config",
  [".yaml.sample"] = "yaml",
}

vim.filetype.add({
  filename = filename,
})
