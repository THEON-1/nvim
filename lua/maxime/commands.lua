-- alias :W for :w
vim.api.nvim_create_user_command('W', function() vim.cmd("w") end, {})

-- autocommand: makefile tab indent
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"makefile"},
    callback = function()
        vim.opt_local.expandtab = false
    end
})

