local ok, onedark = pcall(require, "onedark")
if not ok then
  return
end

local function get_variant()
  local variants = {
    dark = "dark",
    darker = "darker",
    cool = "cool",
    deep = "deep",
    warm = "warm",
    warmer = "warmer",
    light = "light",
  }
  return variants[os.getenv("NVIM_ONEDARK_VARIANT")] or "darker"
end

local config = {}
config.style = get_variant()

onedark.setup(config)
onedark.load()

vim.cmd.colorscheme("onedark")
