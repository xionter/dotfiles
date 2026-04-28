return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        "j-hui/fidget.nvim",
        'artempyanykh/marksman',
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "rust_analyzer",
                "omnisharp",
                "clangd",
                "pyright",
                "ruff",
                "lua_ls",
                "ts_ls",
                "jdtls",
                "gopls",
--                "pylsp",
--                "html-lsp"
            },
            handlers = {
                ["jdtls"] = function()
                    require("lspconfig").jdtls.setup({
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    })
                end,
                ["pyright"] = function()
                    require("lspconfig").pyright.setup({
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        settings = {
                            python = {
                                analysis = {
                                    typeCheckingMode = "basic",
                                    autoSearchPaths = true,
                                    useLibraryCodeForTypes = true,
                                },
                            },
                        },
                    })
                end,
                ["ruff"] = function()
                    require("lspconfig").ruff.setup({
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    })
                end,
                ["ts_ls"] = function()
                    require("lspconfig").ts_ls.setup({
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    })
                end,
                ["omnisharp"] = function()
                    local capabilities = require("cmp_nvim_lsp").default_capabilities()

                    require("lspconfig").omnisharp.setup({
                        capabilities = capabilities,
                        enable_roslyn_analyzers = true,
                        organize_imports_on_format = true,
                        enable_import_completion = true,
                        settings = {
                            omnisharp = {
                                EnableInlayHints = false,
                            },
                        },
                    })
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                hint = { enable = false },  -- Disable Lua inlay hints
                            },
                        },
                    }
                end,
            },
        })
        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            }),
        })
    end,
}
