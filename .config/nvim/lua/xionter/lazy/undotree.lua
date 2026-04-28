return {
    "mbbill/undotree",
    config = function()
        vim.g.undotree_debug = 0
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
}

