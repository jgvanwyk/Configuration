-- PLUGINS
-- Disable builtin plugins.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1

-- Enable builtin plugins.
vim.cmd.packadd("nvim.undotree")

-- Add external plugins.
vim.pack.add {
    "https://github.com/lifepillar/vim-colortemplate",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    -- "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    "https://github.com/ryvnf/readline.vim",
    "https://github.com/justinmk/vim-dirvish",
    "https://github.com/machakann/vim-sandwich",
    "https://github.com/lervag/vimtex",
    ifelse(__OS, macos,
    "https://github.com/lunacookies/vim-colors-xcode",
    __OS, fedora,
    "https://github.com/Mofiqul/adwaita.nvim"
)dnl
}

-- Sandwich
-- Enable Surround key maps emulation in Surround.
vim.cmd.runtime("macros/sandwich/keymap/surround.vim")

vim.o.termguicolors = false
vim.o.showmode = false
vim.o.breakindent = true
vim.o.tabstop = 8
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = -1
vim.o.linebreak = true
vim.o.spelllang = "en_gb"
vim.o.undofile = true
vim.o.smoothscroll = true
vim.o.signcolumn = "number"
vim.o.laststatus = 3
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.winborder = "single"
vim.o.foldlevel = 99
vim.o.formatexpr = ""
vim.o.shell = "zsh"
vim.o.cinoptions = "(1s,m1"
vim.o.statusline = "%f %m%r%= Line %l, Col %c %P %y"
-- vim.o.mouse = ""
vim.o.listchars = "space:·,eol:¬,tab:»  ,trail:·"
vim.o.whichwrap = vim.o.whichwrap .. "<,>,[,]"
ifelse(__OS, macos,
vim.cmd.colorscheme("xcode"),
__OS, fedora,
vim.cmd.colorscheme("adwaita")
)dnl

-- KEY MAPS
vim.keymap.set("n", "<Leader>u", require("undotree").open)
vim.keymap.set("n", "<Leader>c", function() vim.o.list = not vim.o.list end)
vim.keymap.set("n", "<Leader>s", vim.cmd.nohlsearch)
vim.keymap.set("n", "<Leader>b", function()
    vim.o.background = vim.o.background == "light" and "dark" or "light"
end)
vim.keymap.set("n", "<Leader>h", ":help <C-r><C-w><CR>", { silent = true })
vim.keymap.set("n", "<MouseDown>", "<C-y>")
vim.keymap.set("n", "<MouseUp>", "<C-e>")

vim.keymap.set("i", "<CR>", function()
    if vim.fn.pumvisible() ~= 0 then
        vim.fn.feedkeys(vim.keycode("<C-y>"))
    else
        vim.fn.feedkeys(vim.keycode("<CR>"), "n")
    end
end)

vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() ~= 0 then
        vim.fn.feedkeys(vim.keycode("<C-n>"), "n")
    elseif vim.snippet.active({ direction = 1 }) then
        vim.snippet.jump(1)
    else
        vim.fn.feedkeys(vim.keycode("<Tab>"), "n")
    end
end)

vim.keymap.set("i", "<S-Tab>", function()
    if vim.fn.pumvisible() ~= 0 then
        vim.fn.feedkeys(vim.keycode("<C-p>"))
    elseif vim.snippet.active({ direction = -1 }) then
        vim.snippet.jump(-1)
    else
        vim.fn.feedkeys(vim.keycode("<S-Tab>"), "n")
    end
end)

-- AUTOCOMMANDS
-- Restore cursor on open.
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.b.filetype == "gitcommit" then return end
        local pos = vim.fn.getpos("'\"")
        local line_count = vim.fn.line("$")
        if 1 <= line_count and 1 <= pos[2] and pos[2] <= line_count then
            vim.fn.setpos(".", pos)
        end
    end
})

-- Ensure formatoptions never contains "ro" (some file type plugins like to
-- change this).
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove("r")
        vim.opt.formatoptions:remove("o")
    end
})

-- Disable line numbers in floating windows.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        if vim.api.nvim_win_get_config(0).relative == "" then return end
        vim.wo.number = false
    end
})
