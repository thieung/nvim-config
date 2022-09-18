require("mini.sessions").setup({ directory = "~/.config/nvim/misc/sessions" })
require("mini.starter").setup()
vim.cmd([[autocmd User MiniStarterOpened setlocal fillchars=eob:\ ]])

vim.defer_fn(function()
  require("mini.bufremove").setup()
  require("mini.comment").setup()
  require("mini.trailspace").setup()
  require("mini.jump").setup()

  require("mini.surround").setup({ search_method = "cover_or_next" })

  require("mini.pairs").setup({
    modes = { insert = true, command = true, terminal = true },
  })

  require("mini.jump2d").setup({
    mappings = {
      start_jumping = "S",
    },
  })

  require("mini.indentscope").setup({
    draw = {
      delay = 0,
      animation = require("mini.indentscope").gen_animation("none"),
    },
    options = { indent_at_cursor = false },
    symbol = "▏",
  })

  require("mini.ai").setup({
    custom_textojects = {
      F = require("mini.ai").gen_spec.treesitter({
        a = "@function.outer",
        i = "@function.inner",
      }),
    },
  })
end, 0)
