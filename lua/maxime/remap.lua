-- remap goto file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move selection in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- yank to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- paste without copy
vim.keymap.set("x", "<leader>p", "\"_dP")

-- delete without copy
vim.keymap.set("n", "<leader>d", "\"_d");
vim.keymap.set("v", "<leader>d", "\"_d");

-- search and replace hovered word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true})

-- insert shebang on top of file
vim.keymap.set("n", "<leader>sb", function ()
    local filetype = vim.bo.filetype
    local mapping = {
        jl = "julia",
        julia = "julia",
        sh = "bash",
        zsh = "zsh",
        py = "python",
        python = "python",
    }
    local command = mapping[filetype]
    if (command == nil) then return end
    local handle = assert(io.popen(string.format("/bin/zsh -c \"where %s\"", command)))
    local result = (handle:lines())()
    handle:close()
    local buf = vim.api.nvim_get_current_buf()
    print(result)
    vim.api.nvim_buf_set_lines(buf, 0, 0, true, { "#!" .. result })
end)

-- window switching
--vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>")
--vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>")
--vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>")
--vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>")

-- window movement
--vim.keymap.set("n", "<C-Left>", "<cmd>wincmd H<CR>")
--vim.keymap.set("n", "<C-Right>", "<cmd>wincmd L<CR>")
--vim.keymap.set("n", "<C-Up>", "<cmd>wincmd K<CR>")
--vim.keymap.set("n", "<C-Down>", "<cmd>wincmd J<CR>")
--vim.keymap.set("n", "<C-r>", "<cmd>wincmd r<CR>")

