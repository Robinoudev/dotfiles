-- Setup nvim-cmp.
local cmp = require'cmp'
local lspkind = require "lspkind"

-- Setup compe
cmp.setup({
    snippet = {
        expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

        -- For `luasnip` user.
        -- require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        -- vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-u>'] = cmp.mapping.confirm({ select = true }),
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "treesitter" },
      { name = "vsnip" },
      { name = "path" },
      {
        name = "buffer",
        opts = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
        },
      },
      { name = "spell" },
    },
    formatting = {
      format = function(entry, vim_item)
      vim_item.kind = string.format("%s %s", lspkind.presets.default[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = "ﲳ",
        nvim_lua = "",
        treesitter = "",
        path = "ﱮ",
        buffer = "﬘",
        zsh = "",
        vsnip = "",
        spell = "暈",
      })[entry.source.name]

      return vim_item
    end,
  },
})

-- Setup lspconfig.
require('lspconfig').tsserver.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
require('lspconfig').solargraph.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = { solargraph = { diagnostics = true; formatting = true; logLevel = 'debug'; } }
}
require('lspconfig').elixirls.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    cmd = { "/Users/robin/.local/bin/elixir-ls/language_server.sh" };
}
require('lspconfig').vimls.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
require('lspconfig').rust_analyzer.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- Get system for lua
-- local system_name
-- if vim.fn.has("mac") == 1 then
--     system_name = "macOS"
-- elseif vim.fn.has("unix") == 1 then
--     system_name = "Linux"
-- elseif vim.fn.has('win32') == 1 then
--     system_name = "Windows"
-- else
--     print("Unsupported system for sumneko")
-- end

require('lspconfig').sumneko_lua.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    cmd = { '/Users/robin/.local/programs/lua-language-server/bin/macOS/lua-language-server'}
}
