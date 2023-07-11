if vim.g.colors_name then
  vim.cmd.hi("clear")
else
end
vim.g["colors_name"] = "oxoterm"
vim.o["termguicolors"] = true
local pywall = true
local termcolors = true
local c = {
  base00 = "#101010", -- black background
  base01 = "#121212",
  base02 = "#242424",
  base03 = "#555555",
  base04 = "#A7A7A7",
  base05 = "#E4E4E4",
  base06 = "#ffffff", -- white text
  base07 = "#5AF78E", -- costant methods using diff
  base08 = "#61C0FF", -- functions
  base09 = "#78a9ff", -- variables statements
  base10 = "#ee5396", -- error
  base11 = "#33b1ff", -- bars and cmp
  base12 = "#ff7eb6", -- files cmp decorations
  base13 = "#C96DFF", -- statuss line and mode debug trace todo 
  base14 = "#d382c8", -- warning
  base15 = "#9D82FF", -- help types
  blend  = "#111111", -- shadow of base00
  none   = "NONE" -- transparent
}
local tc = {
  base00 = "#101010",
  base01 = "#E4E4E4",
  base02 = "#A7A7A7",
  base03 = "#555555",
  base04 = "#242424",
  base05 = "#121212",
  base06 = "#101010",
  base07 = "#5AF78E",
  base08 = "#61C0FF",
  base09 = "#78a9ff",
  base10 = "#ee5396",
  base11 = "#33b1ff",
  base12 = "#ff7eb6",
  base13 = "#d382c8",
  base14 = "#be95ff",
  base15 = "#9D82FF",
}
-- pywall function
local file_path = os.getenv("HOME") .. "/.cache/wal/colors"
local file_exists = vim.fn.filereadable(file_path) == 1
if file_exists and pywall then
    local file = io.open(file_path, "r")
    if file then
        local i = 0
        for line in file:lines() do
          i = i + 1
          if i ~= 0 and i ~= 1 and termcolors then
            tc["base" .. string.format("%02d", i)] = line
          end
          if i ~= 0 and i ~= 1 and i ~= 2 and i ~= 3 and i ~= 4 and i ~= 5 and i ~= 6 then
            c["base" .. string.format("%02d", i)] = line
            if not termcolors then
              tc["base" .. string.format("%02d", i)] = line
            end
          end
        end
        file:close()
    end
end
if transparent then
  c.base00 = "NONE"
  vim.g.neovide_transparency = 0.0
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#000000" .. string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  vim.api.nvim_set_hl(0, "Background", {fg = c.none, bg = c.none})
end
vim.g["terminal_color_0"] = tc.base00
vim.g["terminal_color_1"] = tc.base01
vim.g["terminal_color_2"] = tc.base02
vim.g["terminal_color_3"] = tc.base03
vim.g["terminal_color_4"] = tc.base04
vim.g["terminal_color_5"] = tc.base05
vim.g["terminal_color_6"] = tc.base06
vim.g["terminal_color_7"] = tc.base07
vim.g["terminal_color_8"] = tc.base08
vim.g["terminal_color_9"] = tc.base09
vim.g["terminal_color_10"] = tc.base10
vim.g["terminal_color_11"] = tc.base11
vim.g["terminal_color_12"] = tc.base12
vim.g["terminal_color_13"] = tc.base13
vim.g["terminal_color_14"] = tc.base14
vim.g["terminal_color_15"] = tc.base15
if transparent then
  vim.api.nvim_set_hl(0, "CursorLine", {fg = c.base00, bg = c.base00})
else
  vim.api.nvim_set_hl(0, "CursorLine", {fg = c.base05, bg = c.base00})
end
vim.api.nvim_set_hl(0, "ColorColumn", {fg = c.base00, bg = c.base01})
vim.api.nvim_set_hl(0, "Cursor", {fg = c.base01, bg = c.base04})
vim.api.nvim_set_hl(0, "CursorColumn", {fg = c.base00, bg = c.base04})
vim.api.nvim_set_hl(0, "CursorLineNr", {fg = c.base05, bg = c.base01})
vim.api.nvim_set_hl(0, "QuickFixLine", {fg = c.base00, bg = c.base02})
vim.api.nvim_set_hl(0, "Error", {fg = c.base10, bg = c.base01})
vim.api.nvim_set_hl(0, "LineNr", {fg = c.base03, bg = c.base00})
vim.api.nvim_set_hl(0, "NonText", {fg = c.base02, bg = c.base00})
vim.api.nvim_set_hl(0, "Normal", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "Pmenu", {fg = c.base04, bg = c.base01})
vim.api.nvim_set_hl(0, "PmenuSbar", {fg = c.base04, bg = c.base01})
vim.api.nvim_set_hl(0, "PmenuSel", {fg = c.base08, bg = c.base02})
vim.api.nvim_set_hl(0, "PmenuThumb", {fg = c.base08, bg = c.base02})
vim.api.nvim_set_hl(0, "SpecialKey", {fg = c.base03, bg = c.base00})
vim.api.nvim_set_hl(0, "Visual", {fg = c.base00, bg = c.base02})
vim.api.nvim_set_hl(0, "VisualNOS", {fg = c.base00, bg = c.base02})
vim.api.nvim_set_hl(0, "TooLong", {fg = c.base00, bg = c.base02})
vim.api.nvim_set_hl(0, "Debug", {fg = c.base13, bg = c.base00})
vim.api.nvim_set_hl(0, "Macro", {fg = c.base07, bg = c.base00})
vim.api.nvim_set_hl(0, "MatchParen", {fg = c.base00, bg = c.base02, underline = true})
vim.api.nvim_set_hl(0, "Bold", {fg = c.base00, bg = c.base00, bold = true})
vim.api.nvim_set_hl(0, "Italic", {fg = c.base00, bg = c.base00, italic = true})
vim.api.nvim_set_hl(0, "Underlined", {fg = c.base00, bg = c.base00, underline = true})
vim.api.nvim_set_hl(0, "DiagnosticWarn", {fg = c.base14, bg = c.base00})
vim.api.nvim_set_hl(0, "DiagnosticError", {fg = c.base10, bg = c.base00})
vim.api.nvim_set_hl(0, "DiagnosticInfo", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "DiagnosticHint", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {fg = c.base14, bg = c.base00, undercurl = true})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {fg = c.base10, bg = c.base00, undercurl = true})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {fg = c.base04, bg = c.base00, undercurl = true})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {fg = c.base04, bg = c.base00, undercurl = true})
vim.api.nvim_set_hl(0, "HealthError", {fg = c.base10, bg = c.base00})
vim.api.nvim_set_hl(0, "HealthWarning", {fg = c.base14, bg = c.base00})
vim.api.nvim_set_hl(0, "HealthSuccess", {fg = c.base13, bg = c.base00})
vim.api.nvim_set_hl(0, "healthSuccess", {fg = c.base13, bg = c.base00})
vim.api.nvim_set_hl(0, "LspReferenceText", {fg = c.base00, bg = c.base03})
vim.api.nvim_set_hl(0, "LspReferenceread", {fg = c.base00, bg = c.base03})
vim.api.nvim_set_hl(0, "LspReferenceWrite", {fg = c.base00, bg = c.base03})
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "Folded", {fg = c.base02, bg = c.base01})
vim.api.nvim_set_hl(0, "FoldColumn", {fg = c.base03, bg = c.base00})
vim.api.nvim_set_hl(0, "SignColumn", {fg = c.base02, bg = c.base00})
vim.api.nvim_set_hl(0, "Directory", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "EndOfBuffer", {fg = c.base01, bg = c.base00})
vim.api.nvim_set_hl(0, "ErrorMsg", {fg = c.base10, bg = c.base00})
vim.api.nvim_set_hl(0, "ModeMsg", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "MoreMsg", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "Question", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "Substitute", {fg = c.base01, bg = c.base08})
vim.api.nvim_set_hl(0, "WarningMsg", {fg = c.base14, bg = c.base00})
vim.api.nvim_set_hl(0, "WildMenu", {fg = c.base08, bg = c.base01})
vim.api.nvim_set_hl(0, "helpHyperTextJump", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "helpSpecial", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "helpHeadline", {fg = c.base10, bg = c.base00})
vim.api.nvim_set_hl(0, "helpHeader", {fg = c.base15, bg = c.base00})
vim.api.nvim_set_hl(0, "DiffAdded", {fg = c.base07, bg = c.base00})
vim.api.nvim_set_hl(0, "DiffChanged", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "DiffRemoved", {fg = c.base10, bg = c.base00})
vim.api.nvim_set_hl(0, "DiffAdd", {bg = "#122f2f", fg = c.base00})
vim.api.nvim_set_hl(0, "DiffChange", {bg = "#222a39", fg = c.base00})
vim.api.nvim_set_hl(0, "DiffText", {bg = "#2f3f5c", fg = c.base00})
vim.api.nvim_set_hl(0, "DiffDelete", {bg = "#361c28", fg = c.base00})
vim.api.nvim_set_hl(0, "IncSearch", {fg = c.base06, bg = c.base10})
vim.api.nvim_set_hl(0, "Search", {fg = c.base01, bg = c.base08})
vim.api.nvim_set_hl(0, "TabLine", {link = "StatusLineNC"})
vim.api.nvim_set_hl(0, "TabLineFill", {link = "TabLine"})
vim.api.nvim_set_hl(0, "TabLineSel", {link = "StatusLine"})
vim.api.nvim_set_hl(0, "Title", {fg = c.base00, bg = c.base00})
vim.api.nvim_set_hl(0, "VertSplit", {fg = c.base01, bg = c.base00})
vim.api.nvim_set_hl(0, "Boolean", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "Character", {fg = c.base15, bg = c.base00})
vim.api.nvim_set_hl(0, "Comment", {fg = c.base03, bg = c.base00, italic = true})
vim.api.nvim_set_hl(0, "Conceal", {fg = c.base00, bg = c.base00})
vim.api.nvim_set_hl(0, "Conditional", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "Constant", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "Decorator", {fg = c.base12, bg = c.base00})
vim.api.nvim_set_hl(0, "Define", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "Delimeter", {fg = c.base06, bg = c.base00})
vim.api.nvim_set_hl(0, "Exception", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "Float", {link = "Number"})
vim.api.nvim_set_hl(0, "Function", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "Identifier", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "Include", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "Keyword", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "Label", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "Number", {fg = c.base15, bg = c.base00})
vim.api.nvim_set_hl(0, "Operator", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "PreProc", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "Repeat", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "Special", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "SpecialChar", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "SpecialComment", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "Statement", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "StorageClass", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "String", {fg = c.base15, bg = c.base00})
vim.api.nvim_set_hl(0, "Structure", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "Tag", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "Todo", {fg = c.base13, bg = c.base00})
vim.api.nvim_set_hl(0, "Type", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "Typedef", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "markdownBlockquote", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "markdownBold", {link = "Bold"})
vim.api.nvim_set_hl(0, "markdownItalic", {link = "Italic"})
vim.api.nvim_set_hl(0, "markdownBoldItalic", {fg = c.base00, bg = c.base00, bold = true, italic = true})
vim.api.nvim_set_hl(0, "markdownRule", {link = "Comment"})
vim.api.nvim_set_hl(0, "markdownH1", {fg = c.base10, bg = c.base00})
vim.api.nvim_set_hl(0, "markdownH2", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "markdownH3", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "markdownH4", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "markdownH5", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "markdownH6", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "markdownHeadingDelimiter", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "markdownHeadingRule", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "markdownUrl", {fg = c.base15, bg = c.base00, underline = true})
vim.api.nvim_set_hl(0, "markdownCode", {link = "String"})
vim.api.nvim_set_hl(0, "markdownCodeBlock", {link = "markdownCode"})
vim.api.nvim_set_hl(0, "markdownCodeDelimiter", {link = "markdownCode"})
vim.api.nvim_set_hl(0, "markdownUrl", {link = "String"})
vim.api.nvim_set_hl(0, "markdownListMarker", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "markdownOrderedListMarker", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "asciidocAttributeEntry", {fg = c.base15, bg = c.base00})
vim.api.nvim_set_hl(0, "asciidocAttributeList", {link = "asciidocAttributeEntry"})
vim.api.nvim_set_hl(0, "asciidocAttributeRef", {link = "asciidocAttributeEntry"})
vim.api.nvim_set_hl(0, "asciidocHLabel", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "asciidocOneLineTitle", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "asciidocQuotedMonospaced", {link = "markdownBlockquote"})
vim.api.nvim_set_hl(0, "asciidocURL", {link = "markdownUrl"})
vim.api.nvim_set_hl(0, "@comment", {link = "Comment"})
vim.api.nvim_set_hl(0, "@error", {fg = c.base10, bg = c.base00})
vim.api.nvim_set_hl(0, "@operator", {link = "Operator"})
vim.api.nvim_set_hl(0, "@puncuation.delimiter", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "@punctuation.bracket", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "@punctuation.special", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "@string", {link = "String"})
vim.api.nvim_set_hl(0, "@string.regex", {fg = c.base07, bg = c.base00})
vim.api.nvim_set_hl(0, "@string.escape", {fg = c.base15, bg = c.base00})
vim.api.nvim_set_hl(0, "@character", {link = "Character"})
vim.api.nvim_set_hl(0, "@boolean", {link = "Boolean"})
vim.api.nvim_set_hl(0, "@number", {link = "Number"})
vim.api.nvim_set_hl(0, "@float", {link = "Float"})
vim.api.nvim_set_hl(0, "@function", {fg = c.base12, bg = c.base00, bold = true})
vim.api.nvim_set_hl(0, "@function.builtin", {fg = c.base12, bg = c.base00})
vim.api.nvim_set_hl(0, "@function.macro", {fg = c.base07, bg = c.base00})
vim.api.nvim_set_hl(0, "@method", {fg = c.base07, bg = c.base00})
vim.api.nvim_set_hl(0, "@constructor", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "@parameter", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "@keyword", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "@keyword.function", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "@keyword.operator", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "@conditional", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "@repeat", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "@label", {fg = c.base15, bg = c.base00})
vim.api.nvim_set_hl(0, "@include", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "@exception", {fg = c.base15, bg = c.base00})
vim.api.nvim_set_hl(0, "@type", {link = "Type"})
vim.api.nvim_set_hl(0, "@type.builtin", {link = "Type"})
vim.api.nvim_set_hl(0, "@attribute", {fg = c.base15, bg = c.base00})
vim.api.nvim_set_hl(0, "@field", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "@property", {fg = c.base10, bg = c.base00})
vim.api.nvim_set_hl(0, "@variable", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "@variable.builtin", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "@constant", {fg = c.base15, bg = c.base00})
vim.api.nvim_set_hl(0, "@constant.builtin", {fg = c.base07, bg = c.base00})
vim.api.nvim_set_hl(0, "@constant.macro", {fg = c.base07, bg = c.base00})
vim.api.nvim_set_hl(0, "@namespace", {fg = c.base07, bg = c.base00})
vim.api.nvim_set_hl(0, "@symbol", {fg = c.base15, bg = c.base00, bold = true})
vim.api.nvim_set_hl(0, "@text", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "@text.strong", {fg = c.base00, bg = c.base00})
vim.api.nvim_set_hl(0, "@text.emphasis", {fg = c.base10, bg = c.base00, bold = true})
vim.api.nvim_set_hl(0, "@text.underline", {fg = c.base10, bg = c.base00, underline = true})
vim.api.nvim_set_hl(0, "@text.strike", {fg = c.base10, bg = c.base00, strikethrough = true})
vim.api.nvim_set_hl(0, "@text.title", {fg = c.base10, bg = c.base00})
vim.api.nvim_set_hl(0, "@text.literal", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "@text.uri", {fg = c.base15, bg = c.base00, underline = true})
vim.api.nvim_set_hl(0, "@tag", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "@tag.attribute", {fg = c.base15, bg = c.base00})
vim.api.nvim_set_hl(0, "@tag.delimiter", {fg = c.base15, bg = c.base00})
vim.api.nvim_set_hl(0, "@reference", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "NvimInternalError", {fg = c.base00, bg = c.base08})
vim.api.nvim_set_hl(0, "NormalFloat", {fg = c.base05, bg = c.blend})
vim.api.nvim_set_hl(0, "FloatBorder", {fg = c.blend, bg = c.blend})
vim.api.nvim_set_hl(0, "NormalNC", {fg = c.base05, bg = c.base00})
vim.api.nvim_set_hl(0, "TermCursor", {fg = c.base00, bg = c.base04})
vim.api.nvim_set_hl(0, "TermCursorNC", {fg = c.base00, bg = c.base04})
vim.api.nvim_set_hl(0, "StatusLine", {fg = c.base04, bg = c.base01}) --bg = c.base01
vim.api.nvim_set_hl(0, "StatusLineNC", {fg = c.base03, bg = c.base01})
vim.api.nvim_set_hl(0, "StatusReplace", {fg = c.base00, bg = c.base08})
vim.api.nvim_set_hl(0, "StatusInsert", {fg = c.base00, bg = c.base12})
vim.api.nvim_set_hl(0, "StatusVisual", {fg = c.base00, bg = c.base15})
vim.api.nvim_set_hl(0, "StatusTerminal", {fg = c.base00, bg = c.base11})
vim.api.nvim_set_hl(0, "StatusNormal", {fg = c.base00, bg = c.base15})
vim.api.nvim_set_hl(0, "StatusCommand", {fg = c.base00, bg = c.base13})
vim.api.nvim_set_hl(0, "StatusLineDiagnosticWarn", {fg = c.base14, bg = c.base00, bold = true})
vim.api.nvim_set_hl(0, "StatusLineDiagnosticError", {fg = c.base10, bg = c.base00, bold = true})
vim.api.nvim_set_hl(0, "TelescopeBorder", {fg = c.blend, bg = c.blend})
vim.api.nvim_set_hl(0, "TelescopePromptBorder", {fg = c.base02, bg = c.base02})
vim.api.nvim_set_hl(0, "TelescopePromptNormal", {fg = c.base05, bg = c.base02})
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", {fg = c.base08, bg = c.base02})
vim.api.nvim_set_hl(0, "TelescopeNormal", {fg = c.base05, bg = c.blend})
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", {fg = c.base02, bg = c.base12})
vim.api.nvim_set_hl(0, "TelescopePromptTitle", {fg = c.base02, bg = c.base11})
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", {fg = c.blend, bg = c.blend})
vim.api.nvim_set_hl(0, "TelescopeSelection", {fg = c.base06, bg = c.base02})
vim.api.nvim_set_hl(0, "TelescopePreviewLine", {fg = c.base00, bg = c.base01})
vim.api.nvim_set_hl(0, "TelescopeMatching", {fg = c.base08, bg = c.base00, bold = true, italic = true})
vim.api.nvim_set_hl(0, "NotifyERRORBorder", {fg = c.base08, bg = c.none})
vim.api.nvim_set_hl(0, "NotifyWARNBorder", {fg = c.base14, bg = c.none})
vim.api.nvim_set_hl(0, "NotifyINFOBorder", {fg = c.base05, bg = c.none})
vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", {fg = c.base13, bg = c.none})
vim.api.nvim_set_hl(0, "NotifyTRACEBorder", {fg = c.base13, bg = c.none})
vim.api.nvim_set_hl(0, "NotifyERRORIcon", {fg = c.base08, bg = c.none})
vim.api.nvim_set_hl(0, "NotifyWARNIcon", {fg = c.base14, bg = c.none})
vim.api.nvim_set_hl(0, "NotifyINFOIcon", {fg = c.base05, bg = c.none})
vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", {fg = c.base13, bg = c.none})
vim.api.nvim_set_hl(0, "NotifyTRACEIcon", {fg = c.base13, bg = c.none})
vim.api.nvim_set_hl(0, "NotifyERRORTitle", {fg = c.base08, bg = c.none})
vim.api.nvim_set_hl(0, "NotifyWARNTitle", {fg = c.base14, bg = c.none})
vim.api.nvim_set_hl(0, "NotifyINFOTitle", {fg = c.base05, bg = c.none})
vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", {fg = c.base13, bg = c.none})
vim.api.nvim_set_hl(0, "NotifyTRACETitle", {fg = c.base13, bg = c.none})
vim.api.nvim_set_hl(0, "CmpItemAbbr", {fg = c.base05, bg = c.base00}) -- fg = "#adadad"
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", {fg = c.base05, bg = c.base00, bold = true})
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", {fg = c.base04, bg = c.base00, bold = true})
vim.api.nvim_set_hl(0, "CmpItemMenu", {fg = c.base04, bg = c.base00, italic = true})
vim.api.nvim_set_hl(0, "CmpItemKindInterface", {fg = c.base01, bg = c.base08})
vim.api.nvim_set_hl(0, "CmpItemKindColor", {fg = c.base01, bg = c.base08})
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", {fg = c.base01, bg = c.base08})
vim.api.nvim_set_hl(0, "CmpItemKindText", {fg = c.base01, bg = c.base09})
vim.api.nvim_set_hl(0, "CmpItemKindEnum", {fg = c.base01, bg = c.base09})
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", {fg = c.base01, bg = c.base09})
vim.api.nvim_set_hl(0, "CmpItemKindConstant", {fg = c.base01, bg = c.base10})
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", {fg = c.base01, bg = c.base10})
vim.api.nvim_set_hl(0, "CmpItemKindReference", {fg = c.base01, bg = c.base10})
vim.api.nvim_set_hl(0, "CmpItemKindFunction", {fg = c.base01, bg = c.base11})
vim.api.nvim_set_hl(0, "CmpItemKindStruct", {fg = c.base01, bg = c.base11})
vim.api.nvim_set_hl(0, "CmpItemKindClass", {fg = c.base01, bg = c.base11})
vim.api.nvim_set_hl(0, "CmpItemKindModule", {fg = c.base01, bg = c.base11})
vim.api.nvim_set_hl(0, "CmpItemKindOperator", {fg = c.base01, bg = c.base11})
vim.api.nvim_set_hl(0, "CmpItemKindField", {fg = c.base01, bg = c.base12})
vim.api.nvim_set_hl(0, "CmpItemKindProperty", {fg = c.base01, bg = c.base12})
vim.api.nvim_set_hl(0, "CmpItemKindEvent", {fg = c.base01, bg = c.base12})
vim.api.nvim_set_hl(0, "CmpItemKindUnit", {fg = c.base01, bg = c.base13})
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", {fg = c.base01, bg = c.base13})
vim.api.nvim_set_hl(0, "CmpItemKindFolder", {fg = c.base01, bg = c.base13})
vim.api.nvim_set_hl(0, "CmpItemKindVariable", {fg = c.base01, bg = c.base15})
vim.api.nvim_set_hl(0, "CmpItemKindFile", {fg = c.base01, bg = c.base15})
vim.api.nvim_set_hl(0, "CmpItemKindMethod", {fg = c.base01, bg = c.base15})
vim.api.nvim_set_hl(0, "CmpItemKindValue", {fg = c.base01, bg = c.base15})
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", {fg = c.base01, bg = c.base15})
vim.api.nvim_set_hl(0, "NvimTreeImageFile", {fg = c.base12, bg = c.base00})
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", {fg = c.base12, bg = c.base00})
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", {fg = c.base00, bg = c.base00})
vim.api.nvim_set_hl(0, "NvimTreeFolderName", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", {fg = c.base02, bg = c.base00})
vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", {fg = c.base15, bg = c.base00})
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", {fg = c.base15, bg = c.base00})
vim.api.nvim_set_hl(0, "NvimTreeNormal", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "NeogitBranch", {fg = c.base10, bg = c.base00})
vim.api.nvim_set_hl(0, "NeogitRemote", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "NeogitHunkHeader", {fg = c.base04, bg = c.base02})
vim.api.nvim_set_hl(0, "NeogitHunkHeaderHighlight", {fg = c.base04, bg = c.base03})
vim.api.nvim_set_hl(0, "HydraRed", {fg = c.base12, bg = c.base00})
vim.api.nvim_set_hl(0, "HydraBlue", {fg = c.base09, bg = c.base00})
vim.api.nvim_set_hl(0, "HydraAmaranth", {fg = c.base10, bg = c.base00})
vim.api.nvim_set_hl(0, "HydraTeal", {fg = c.base08, bg = c.base00})
vim.api.nvim_set_hl(0, "HydraHint", {fg = c.base00, bg = c.blend})
vim.api.nvim_set_hl(0, "alpha1", {fg = c.base03, bg = c.base00})
vim.api.nvim_set_hl(0, "alpha2", {fg = c.base04, bg = c.base00})
vim.api.nvim_set_hl(0, "alpha3", {fg = c.base03, bg = c.base00})
vim.api.nvim_set_hl(0, "CodeBlock", {fg = c.base00, bg = c.base01})
vim.api.nvim_set_hl(0, "BufferLineDiagnostic", {fg = c.base10, bg = c.base00, bold = true})
vim.api.nvim_set_hl(0, "BufferLineDiagnosticVisible", {fg = c.base10, bg = c.base00, bold = true})
vim.api.nvim_set_hl(0, "htmlH1", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "mkdRule", {link = "markdownRule"})
vim.api.nvim_set_hl(0, "mkdListItem", {link = "markdownListMarker"})
vim.api.nvim_set_hl(0, "mkdListItemCheckbox", {link = "markdownListMarker"})
vim.api.nvim_set_hl(0, "VimwikiHeader1", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "VimwikiHeader2", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "VimwikiHeader3", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "VimwikiHeader4", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "VimwikiHeader5", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "VimwikiHeader6", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "VimwikiHeaderChar", {link = "markdownH1"})
vim.api.nvim_set_hl(0, "VimwikiList", {link = "markdownListMarker"})
vim.api.nvim_set_hl(0, "VimwikiLink", {link = "markdownUrl"})
vim.api.nvim_set_hl(0, "VimwikiCode", {link = "markdownCode"})
--Parentesis
vim.api.nvim_set_hl(0, "TSRainbowRed", {fg= c.base10})
vim.api.nvim_set_hl(0, "TSRainbowYellow", {fg= c.base12})
vim.api.nvim_set_hl(0, "TSRainbowBlue", {fg= c.base13})
vim.api.nvim_set_hl(0, "TSRainbowOrange", {fg= c.base14})
vim.api.nvim_set_hl(0, "TSRainbowGreen", {fg= c.base15})
vim.api.nvim_set_hl(0, "TSRainbowViolet", {fg= c.base09})
vim.api.nvim_set_hl(0, "TSRainbowCyan", {fg= c.base11})
--Dashboard
vim.api.nvim_set_hl(0, "DashboardRecent", {fg = c.base09})
vim.api.nvim_set_hl(0, "DashboardConfiguration", {fg = c.base15})
vim.api.nvim_set_hl(0, "DashboardSession", {fg = c.base10})
vim.api.nvim_set_hl(0, "DashboardLazy", {fg = c.base11})
vim.api.nvim_set_hl(0, "DashboardServer", {fg = c.base13})
vim.api.nvim_set_hl(0, "DashboardQuit", {fg = c.base12})
return {oxoterm = c}
