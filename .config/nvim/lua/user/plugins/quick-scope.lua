local function configure()
  vim.cmd("highlight QuickScopePrimary guifg='#d65d0e' gui=underline ctermfg=155 cterm=underline")
  vim.cmd("highlight QuickScopeSecondary guifg='#427b58' gui=underline ctermfg=81 cterm=underline")
end

return {
  "unblevable/quick-scope",
  config = configure,
}
