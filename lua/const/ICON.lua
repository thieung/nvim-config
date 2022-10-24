local Icon = {}

Icon.STATE = {
  MODIFIED = "",
  READONLY = "",
}

Icon.STATUSLINE = {
  VIM = "",
  FILE_MODIFIED = "",
  FILE_READONLY = "",
  GIT_BRANCH = " ",
  GIT_ADD = "",
  GIT_CHANGE = "",
  GIT_DELETE = "",
  ELLIPSIS = "…",
  SPELLCHECK = "暈",
  PASTE = "",
  DIAG_ERROR = "",
  DIAG_WARN = "",
  DIAG_INFO = "",
  DIAG_HINT = "",
  ACTIVE_LSP = "",
  ACTIVE_TS = "綠",
}

return Icon
