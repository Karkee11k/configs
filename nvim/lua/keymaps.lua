-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}


-------------------
--- Normal mode ---
-------------------
vim.g.mapleader = " "
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)
vim.keymap.set('n', '<C-c>', ':nohl<CR>',  { desc = "Clears the search highlights", silent = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
   

-------------------
--- Visual mode ---
-------------------
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
