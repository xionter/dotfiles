return {
    {
        "neovim/nvim-lspconfig",

        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",

            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",

            "j-hui/fidget.nvim",

            "artempyanykh/marksman",
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
                    "gopls",
                    "html",
                    "cssls",
                    "eslint",
                },
            })

            local capabilities =
                require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("html", {
                capabilities = capabilities,
            })

            vim.lsp.config("cssls", {
                capabilities = capabilities,
            })

            vim.lsp.config("pyright", {
                capabilities = capabilities,

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

            vim.lsp.config("ruff", {
                capabilities = capabilities,
            })

            vim.lsp.config("ts_ls", {
                capabilities = capabilities,

                root_dir = function(bufnr, on_dir)
                    local root = vim.fs.root(bufnr, {
                        "package.json",
                        "tsconfig.json",
                        "jsconfig.json",
                        ".git",
                    })

                    if root then
                        on_dir(root)
                    end
                end,

                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                        },
                    },

                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                        },
                    },
                },
            })

            vim.lsp.config("eslint", {
                capabilities = capabilities,
            })

            vim.lsp.config("omnisharp", {
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

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,

                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },

                        hint = {
                            enable = false,
                        },
                    },
                },
            })

            vim.lsp.enable({
                "html",
                "cssls",
                "jdtls",
                "pyright",
                "ruff",
                "ts_ls",
                "eslint",
                "omnisharp",
                "lua_ls",
                "rust_analyzer",
                "clangd",
                "gopls",
            })

            local cmp = require("cmp")

            local cmp_select = {
                behavior = cmp.SelectBehavior.Select,
            }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] =
                        cmp.mapping.select_prev_item(cmp_select),

                    ["<C-n>"] =
                        cmp.mapping.select_next_item(cmp_select),

                    ["<C-y>"] =
                        cmp.mapping.confirm({ select = true }),

                    ["<C-Space>"] =
                        cmp.mapping.complete(),
                }),

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },{
                    { name = "buffer" },
                }),
            })
        end,
    },
}
