return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "asm", "cpp", "go", "c_sharp", "c", "lua", "rust", "python",
                "cmake", "bash", "javascript", "typescript", "html",
                "markdown",
                "markdown_inline",
            },

            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            indent = {
                enable = true,
            },
        })
    end
}
