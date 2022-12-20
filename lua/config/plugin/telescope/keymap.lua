local keymap = require("utils").Keymap
local map, leader, n = keymap.map, keymap.modifier.leader, keymap.mode.normal
local telescope_builtin = require("telescope.builtin")
local telescope_theme = require("telescope.themes")

keymap.bind({
  -- find
  n(map(leader("ff"), function()
    telescope_builtin.find_files()
  end)),
  n(map(leader("fa"), function()
    telescope_builtin.find_files({ hidden = true, no_ignore = true })
  end)),
  n(map(leader("fw"), function()
    telescope_builtin.live_grep()
  end)),
  n(map(leader("fW"), function()
    telescope_builtin.live_grep({
      additional_args = function(args)
        return vim.list_extend(args, { "--hidden", "--no-ignore" })
      end,
    })
  end)),
  n(map(leader("fb"), function()
    telescope_builtin.buffers()
  end)),
  n(map(leader("fo"), function()
    telescope_builtin.oldfiles()
  end)),
  n(map(leader("fc"), function()
    telescope_builtin.grep_string()
  end)),
  n(map(leader("fe"), function()
    require("telescope").extensions.file_browser.file_browser()
  end)), -- telescope file browser

  -- git
  n(map(leader("gb"), function()
    telescope_builtin.git_branches()
  end)),
  n(map(leader("gc"), function()
    telescope_builtin.git_commits()
  end)),
  n(map(leader("gS"), function()
    telescope_builtin.git_status()
  end)),

  -- diagnostics
  n(map(leader("ld"), function()
    telescope_builtin.diagnostics(telescope_theme.get_dropdown({
      bufnr = 0,
    }))
  end)),
  n(map(leader("lD"), function()
    telescope_builtin.diagnostics()
  end)),
}, {})

require("utils").Augroup("attach_telescope_lsp_keymap", function(autocmd)
  autocmd("LspAttach", "*", function(args)
    if not args.data then
      return
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local capabilities_map = {
      documentSymbolProvider = {
        key = "[ls",
        fn = function()
          require("telescope.builtin").lsp_document_symbols()
        end,
      },
      workspaceSymbolProvider = {
        key = "[lS",
        fn = function()
          require("telescope.builtin").lsp_workspace_symbols()
        end,
      },
      referencesProvider = {
        key = "[lr",
        fn = function()
          require("telescope.builtin").lsp_references()
        end,
      },
      implementationProvider = {
        key = "[li",
        fn = function()
          require("telescope.builtin").lsp_implementations()
        end,
      },
      definitionProvider = {
        key = "[gd",
        fn = function()
          require("telescope.builtin").lsp_definitions()
        end,
      },
    }

    for capability, bind in pairs(capabilities_map) do
      if client.server_capabilities[capability] then
        vim.api.nvim_buf_set_keymap(args.buf, "n", bind.key, "", {
          silent = true,
          noremap = true,
          callback = bind.fn,
        })
      end
    end
  end)
end)
