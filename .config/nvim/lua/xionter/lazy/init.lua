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
    "ej-shafran/compile-mode.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.g.compile_mode = {
            default_command = {
                python = "python %",
                c = "cc -o %:r % && ./%:r",
                go = "go run .",
            }
        }
    end
},
{
    'vague2k/vague.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme vague")
        require("vague").setup({

        })
    end,
},
}
