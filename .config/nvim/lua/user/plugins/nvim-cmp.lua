local function load_snippets()
  require("luasnip.loaders.from_vscode").lazy_load()
end

local function make_completion_behavior_table()
  return { completeopt = "menu,menuone,preview,noselect" }
end

local function make_snippet_behavior_table()
  local luasnip = require("luasnip")
  return { expand = function(args) luasnip.lsp_expand(args.body) end }
end

local function make_mapping_table()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  local function make_tab_mapping()
    return cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" })
  end

  local function make_shift_tab_mapping()
    return cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" })
  end

  return {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = make_tab_mapping(),
    ["<S-Tab>"] = make_shift_tab_mapping(),
  }
end

local function make_autocompletion_sources_table()
  -- See: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
  return {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }
end

local function make_formatting_table()
  return {
    format = require("lspkind").cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  }
end

local function configure()
  local cmp = require("cmp")
  load_snippets()
  cmp.setup({
    completion = make_completion_behavior_table(),
    snippet = make_snippet_behavior_table(),
    mapping = cmp.mapping.preset.insert(make_mapping_table()),
    sources = cmp.config.sources(make_autocompletion_sources_table()),
    formatting = make_formatting_table(),
  })
end

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
  },
  config = configure
}
