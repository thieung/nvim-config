local c = require("colors.utils").colors
local s = require("colors.utils").styles
local g = require("colors.utils").groups
local Group = require("colors.utils").Group

-- references
Group.new("LspReferenceText", c.black:dark(0.05), c.white)
Group.new("LspReferenceRead", c.black:dark(0.05), c.white)
Group.new("LspReferenceWrite", c.black:dark(0.05), c.white)

-- Diagnostic
Group.new("DiagnosticHint", c.pink)
Group.new("DiagnosticError", c.red)
Group.new("DiagnosticWarn", c.yellow)
Group.new("DiagnosticInfo", c.green)
Group.new("DiagnosticVirtualTextError", g.DiagnosticError)
Group.new("DiagnosticVirtualTextHint", g.DiagnosticHint)
Group.new("DiagnosticVirtualTextInfo", g.DiagnosticInfo)
Group.new("DiagnosticVirtualTextWarn", g.DiagnosticWarn)
Group.new("DiagnosticSignError", g.DiagnosticError)
Group.new("DiagnosticSignHint", g.DiagnosticHint)
Group.new("DiagnosticSignInfo", g.DiagnosticInfo)
Group.new("DiagnosticSignWarning", g.DiagnosticWarn)
Group.new("DiagnosticFloatingInfo", g.DiagnosticInfo)
Group.new("DiagnosticFloatingWarn", g.DiagnosticWarn)
Group.new("DiagnosticFloatingError", g.DiagnosticError)
Group.new("DiagnosticFloatingHint", g.DiagnosticHint)
Group.new("DiagnosticUnderlineHint", g.DiagnosticHint, nil, s.underline)
Group.new("DiagnosticUnderlineError", g.DiagnosticError, nil, s.underline)
Group.new("DiagnosticUnderlineWarn", g.DiagnosticWarn, nil, s.underline)
Group.new("DiagnosticUnderlineInfo", g.DiagnosticInfo, nil, s.underline)
Group.new("LspDiagnosticError", g.DiagnosticError)
Group.new("LspDiagnosticHint", g.DiagnosticHint)
Group.new("LspDiagnosticInformation", g.DiagnosticInfo)
Group.new("LspDiagnosticWarning", g.DiagnosticWarn)
Group.new("LspDiagnosticDefaultError", g.DiagnosticError)
Group.new("LspDiagnosticDefaultHint", g.DiagnosticHint)
Group.new("LspDiagnosticDefaultInformation", g.DiagnosticInfo)
Group.new("LspDiagnosticDefaultWarning", g.DiagnosticWarn)
Group.new("LspDiagnosticVirtualTextError", g.DiagnosticError)
Group.new("LspDiagnosticVirtualTextHint", g.DiagnosticHint)
Group.new("LspDiagnosticVirtualTextInformation", g.DiagnosticInfo)
Group.new("LspDiagnosticVirtualTextWarning", g.DiagnosticWarn)
Group.new("LspDiagnosticSignError", g.DiagnosticError)
Group.new("LspDiagnosticSignHint", g.DiagnosticHint)
Group.new("LspDiagnosticSignInformation", g.DiagnosticInfo)
Group.new("LspDiagnosticSignWarning", g.DiagnosticWarn)
Group.new("LspDiagnosticFloatingInformation", g.DiagnosticInfo)
Group.new("LspDiagnosticFloatingWarning", g.DiagnosticWarn)
Group.new("LspDiagnosticFloatingError", g.DiagnosticError)
Group.new("LspDiagnosticFloatingHint", g.DiagnosticHint)
Group.new("LspDiagnosticUnderlineError", g.DiagnosticError, nil, s.underline)
Group.new("LspDiagnosticUnderlineHint", g.DiagnosticHint, nil, s.underline)
Group.new("LspDiagnosticUnderlineWarning", g.DiagnosticWarn, nil, s.underline)
Group.new(
  "LspDiagnosticUnderlineInformation",
  g.DiagnosticInfo,
  nil,
  s.underline
)

-- codelens
Group.new("LspCodeLens", c.grey:dark())

-- others
Group.new("LspFloatWinNormal", c.yellow, c.base00)
Group.new("LspSignatureActiveParameter", c.blue:light())
Group.new("RenamerTitle", c.black, c.red)
Group.new("RenamerBorder", c.red)
