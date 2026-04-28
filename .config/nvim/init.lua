vim.opt.shortmess = vim.opt.shortmess - "S"
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.expandtab = true
        vim.bo.autoindent = true
        vim.bo.smartindent = true
    end,
})
require("xionter.remap")
require("xionter.set")
require("xionter.lazy_init")
