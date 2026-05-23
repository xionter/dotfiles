return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function() 
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python", "go", "c_sharp", "c", "lua",
          "cmake", "bash", "javascript", "typescript", "html",
          "markdown", "markdown_inline",
        },
        auto_install = true,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end

  }
}
