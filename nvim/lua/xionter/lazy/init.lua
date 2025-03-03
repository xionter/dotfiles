return {
    "nvim-lua/plenary.nvim",
    "ThePrimeagen/vim-be-good",
    {"SunnyTamang/pendulum.nvim",
        config = function()
            require"pendulum".setup({
            })
        end

    },
    {
        'jesseleite/nvim-noirbuddy',
        dependencies = {
            { 'tjdevries/colorbuddy.nvim' }
        },
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme noirbuddy")
            require("noirbuddy").setup({
                preset = 'crt-green',
                colors = {
                    background = '#0D120D',
                    primary = '#8A9A5B',
                    secondary = '#E9F5E9',
                    noir_0 = '#C3D8A8',
                    noir_1 = '#B5C89E',
                    noir_2 = '#9AA69A',
                    noir_3 = '#808B80',
                    noir_4 = '#707970',
                    noir_5 = '#616861',
                    noir_6 = '#4F584F',
                    noir_7 = '#3D463D',
                    noir_8 = '#303630',
                    noir_9 = '#282E28',
                    diagnostic_error = '#800020',
                    diagnostic_warning = '#800020',
                    diagnostic_info = '#800020',
                    diagnostic_hint = '#800020',
                    diff_add = '#800020',
                    diff_change = '#800020',
                    diff_delete = '#800020', 
                },
        })
        end,
    },

    --{"ntk148v/komau.vim", name = "komau",
    --config = function()
    --    vim.cmd("colorscheme komau")
    --end},
}
