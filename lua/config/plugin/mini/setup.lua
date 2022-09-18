require("mini.bufremove").setup({})
require("mini.comment").setup({})
require("mini.trailspace").setup({})
require("mini.jump").setup({})
require("mini.surround").setup({})
require("mini.pairs").setup({})

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
  mappings = {
    object_scope = "",
    object_scope_with_border = "",
    goto_top = "",
    goto_bottom = "",
  },
  options = { indent_at_cursor = false },
  symbol = "▏",
})

local gen_spec = require("mini.ai").gen_spec
require("mini.ai").setup({
  custom_textobjects = {
    ["*"] = gen_spec.pair("*", "*", { type = "greedy" }),
    ["_"] = gen_spec.pair("_", "_", { type = "greedy" }),
  },
})
