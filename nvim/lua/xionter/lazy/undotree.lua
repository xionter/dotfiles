return {
    "mbbill/undotree",
    config = function()
        -- Disable debug logging for undotree
        vim.g.undotree_debug = 0

        -- Key mapping for toggling undotree
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
}

