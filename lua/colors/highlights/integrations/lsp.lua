local c = require("colors.utils").colors
local s = require("colors.utils").styles
local g = require("colors.utils").groups
local Group = require("colors.utils").Group

-- references
Group.new("LspReferenceText", c.black:dark(0.05), c.white)
Group.new("LspReferenceRead", c.black:dark(0.05), c.white)
Group.new("LspReferenceWrite", c.black:dark(0.05), c.white)

-- diagnostics
Group.new("DiagnosticHint", c.purple)
Group.new("DiagnosticError", c.red)
Group.new("DiagnosticWarn", c.yellow)
Group.new("DiagnosticInfo", c.green)
Group.new("DiagnosticsVirtualTextError", g.DiagnosticError)
Group.new("DiagnosticsVirtualTextHint", g.DiagnosticHint)
Group.new("DiagnosticsVirtualTextInfo", g.DiagnosticInfo)
Group.new("DiagnosticsVirtualTextWarning", g.DiagnosticWarn)
Group.new("DiagnosticsSignError", g.DiagnosticError)
Group.new("DiagnosticsSignHint", g.DiagnosticHint)
Group.new("DiagnosticsSignInfo", g.DiagnosticInfo)
Group.new("DiagnosticsSignWarning", g.DiagnosticWarn)
Group.new("DiagnosticsFloatingInfo", g.DiagnosticInfo)
Group.new("DiagnosticsFloatingWarning", g.DiagnosticWarn)
Group.new("DiagnosticsFloatingError", g.DiagnosticError)
Group.new("DiagnosticsFloatingHint", g.DiagnosticHint)
Group.new("DiagnosticUnderlineHint", g.DiagnosticHint, nil, s.underline)
Group.new("DiagnosticUnderlineError", g.DiagnosticError, nil, s.underline)
Group.new("DiagnosticUnderlineWarn", g.DiagnosticWarn, nil, s.underline)
Group.new("DiagnosticUnderlineInfo", g.DiagnosticInfo, nil, s.underline)
Group.new("LspDiagnosticsError", g.DiagnosticError)
Group.new("LspDiagnosticsHint", g.DiagnosticHint)
Group.new("LspDiagnosticsInformation", g.DiagnosticInfo)
Group.new("LspDiagnosticsWarning", g.DiagnosticWarn)
Group.new("LspDiagnosticsDefaultError", g.DiagnosticError)
Group.new("LspDiagnosticsDefaultHint", g.DiagnosticHint)
Group.new("LspDiagnosticsDefaultInformation", g.DiagnosticInfo)
Group.new("LspDiagnosticsDefaultWarning", g.DiagnosticWarn)
Group.new("LspDiagnosticsVirtualTextError", g.DiagnosticError)
Group.new("LspDiagnosticsVirtualTextHint", g.DiagnosticHint)
Group.new("LspDiagnosticsVirtualTextInformation", g.DiagnosticInfo)
Group.new("LspDiagnosticsVirtualTextWarning", g.DiagnosticWarn)
Group.new("LspDiagnosticsSignError", g.DiagnosticError)
Group.new("LspDiagnosticsSignHint", g.DiagnosticHint)
Group.new("LspDiagnosticsSignInformation", g.DiagnosticInfo)
Group.new("LspDiagnosticsSignWarning", g.DiagnosticWarn)
Group.new("LspDiagnosticsFloatingInformation", g.DiagnosticInfo)
Group.new("LspDiagnosticsFloatingWarning", g.DiagnosticWarn)
Group.new("LspDiagnosticsFloatingError", g.DiagnosticError)
Group.new("LspDiagnosticsFloatingHint", g.DiagnosticHint)
Group.new("LspDiagnosticsUnderlineError", g.DiagnosticError, nil, s.underline)
Group.new("LspDiagnosticsUnderlineHint", g.DiagnosticHint, nil, s.underline)
Group.new("LspDiagnosticsUnderlineWarning", g.DiagnosticWarn, nil, s.underline)
Group.new(
  "LspDiagnosticsUnderlineInformation",
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
