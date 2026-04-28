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
        -- Setup Mason
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "rust_analyzer",
                "omnisharp",
                "clangd",
                "pylsp",
                "cmake",
                "asm_lsp",  -- Ensure asm_lsp is installed
                "bashls",
            },
            handlers = {
                function(server_name)  -- Default handler
                    require("lspconfig")[server_name].setup {}
                end,
               ["asm_lsp"] = function()  -- Custom handler for asm_lsp
                    require("lspconfig").asm_lsp.setup {
                        cmd = { "/usr/bin/asm-lsp" },
                        filetypes = {  "s" },
                        root_dir = function() return vim.loop.cwd() end,
                        single_file_support = true,
                        settings = {
                            diagnostics = {
                                enable = true,
                                logLevel = "debug",  -- Debug logging
                            },
                        },
                    }
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup {
                        settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" },
                                    },
                                },
                            },
                        }
                end,
            },
        })

        -- Setup nvim-cmp
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

        vim.diagnostic.config({
            virtual_text = false,
            severity_sort = true,
            underline = false,
        })
        vim.cmd [[
        augroup MyHighlightSettings
        autocmd!
        autocmd ColorScheme * highlight DiagnosticUnnecessary ctermfg=NONE guifg=NONE
        autocmd ColorScheme * highlight Comment ctermfg=NONE guifg=NONE
        autocmd ColorScheme * highlight DiagnosticUnderlineWarn cterm=NONE gui=NONE

        augroup END
        ]]

        -- Ensure highlight is applied after ColorScheme changes
        vim.cmd [[
        highlight DiagnosticUnnecessary ctermfg=NONE guifg=NONE
        highlight Comment ctermfg=NONE guifg=NONE
        highlight DiagnosticUnderlineWarn ctermfg=NONE guifg=NONE
        ]]
        -- Ensure correct filetype for assembly
        vim.cmd [[
            augroup FiletypeDetection
                autocmd!
                autocmd BufReadPre *.asm setlocal filetype=asm
            augroup END
        ]]
    end,
}

