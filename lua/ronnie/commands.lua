return {
  {
    ":LineNumbers",
    function()
      rn.ToggleLineNumbers()
    end,
    description = "Toggle line numbers",
  },
  {
    ":ChangeFiletype",
    function()
      rn.ChangeFiletype()
    end,
    description = "Change filetype of current buffer",
  },
  {
    ":CopyMessage",
    function()
      vim.cmd([[let @+ = execute('messages')]])
    end,
    description = "Copy message output",
  },
  {
    ":copen",
    description = "Open quickfix window",
  },
  {
    ":cclose",
    description = "Close quickfix window",
  },
  {
    itemgroup = "Find and Replace (Global)",
    icon = "",
    description = "Find and replace across the project",
    commands = {
      {
        "FindAndReplace",
        function(opts)
          vim.api.nvim_command(
            string.format("silent cdo s/%s/%s", opts.fargs[1], opts.fargs[2])
          )
          vim.api.nvim_command("silent cfdo update")
        end,
        description = "Find and Replace (after quickfix)",
        unfinished = true,
        opts = { nargs = "*" },
      },
      {
        "FindAndReplaceUndo",
        function(opts)
          vim.api.nvim_command("silent cdo undo")
        end,
        description = "Undo Find and Replace",
      },
    },
  },
  {
    "GitBranchList",
    function()
      rn.ListBranches()
    end,
    description = "List the Git branches in this repo",
  },
  {
    "GitRemoteSync",
    function()
      rn.GitRemoteSync()
    end,
    description = "Git sync remote repo",
  },
  {
    "Lazygit",
    function()
      rn.Lazygit():toggle()
    end,
    description = "Git terminal",
  },
  {
    ":New",
    ":enew",
    description = "New buffer",
  },
  {
    ":Snippets",
    function()
      rn.EditSnippet()
    end,
    description = "Edit Snippets",
  },
  {
    ":Theme",
    function()
      rn.ToggleTheme()
    end,
    description = "Toggle theme",
  },
  {
    ":Uuid",
    function()
      local uuid = vim.fn.system("uuidgen"):gsub("\n", ""):lower()
      local line = vim.fn.getline(".")
      vim.schedule(function()
        vim.fn.setline(
          ".",
          vim.fn.strpart(line, 0, vim.fn.col("."))
            .. uuid
            .. vim.fn.strpart(line, vim.fn.col("."))
        )
      end)
    end,
    description = "Generate a UUID and insert it into the buffer",
  },
}
