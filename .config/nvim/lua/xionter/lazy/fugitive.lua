return {
    "tpope/vim-fugitive",
    dependecies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        vim.keymap.set("n", "<leader>gs", function () vim.cmd("tab Git") end)

        local tushonochki_Fugitive = vim.api.nvim_create_augroup("tushonochki_Fugitive", {})

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = tushonochki_Fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = {buffer = bufnr, remap = false}
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, opts)

                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd("Git pull --rebase")
                end, opts)

                vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
            end,
        })
    end}
