local With = {}

local plaintext = {
  "gitcommit",
  "markdown",
  "txt",
}

With.eslint_d = {
  condition = function(u)
    return u.root_has_file({
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      ".eslintrc.json",
    })
  end,
  extra_filetypes = { "svelte" },
}

With.golangci_lint = {
  condition = function(u)
    return u.root_has_file({
      ".golangci.yml",
      ".golangci.yaml",
      ".golangci.toml",
      ".golangci.json",
    })
  end,
}

With.prettierd = {
  condition = function(u)
    return u.root_has_file({
      ".prettierrc",
      ".prettierrc.yml",
      ".prettierrc.json",
    })
  end,
  extra_filetypes = { "svelte" },
}

With.shfmt = {
  extra_args = { "-i", "4", "-ci" },
}

With.stylelint = {
  condition = function(u)
    return u.root_has_file({
      ".stylelintrc",
      ".stylelintrc.json",
      ".stylelintrc.yml",
      ".stylelintrc.js",
      "stylelint.config.js",
      "stylelint.config.cjs",
    })
  end,
}

With.stylua = {
  condition = function(u)
    return u.root_has_file({ "stylua.toml", ".stylua.toml" })
  end,
}

With.write_good = {
  filetypes = plaintext,
}

return With
