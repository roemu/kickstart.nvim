-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1;

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- vim.o.shell = "/bin/zsh -i"

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.scrolloff = 5
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.clipboard = "unnamedplus"

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>rt', [[:execute '%s/\t/    /g'<CR>]])

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', 'n', '    nzz')
vim.keymap.set('n', 'N', 'Nzz')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>ef', vim.diagnostic.open_float, { desc = '[E]rror [F]loat' })
vim.keymap.set('n', '<leader>el', vim.diagnostic.setloclist, { desc = '[E]rror [L]ist' })

vim.api.nvim_set_keymap("n", "gx", [[:execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]], {})
vim.keymap.set("n", "<leader>rw", [[:%s/<C-r><C-w>//g<Left><Left>]])
vim.keymap.set('n', '<leader>ts', '<cmd>silent exec "!~/.config/tmux/tmux-sesh.sh"<CR>', { desc = '[T]mux [S]essions' })

vim.api.nvim_create_augroup('EditingHelper', { clear = false })
vim.api.nvim_create_autocmd('BufWritePre', {
	group = 'EditingHelper',
	pattern = '*',
	command = [[%s/\s\+$//e]],
})
vim.api.nvim_create_autocmd('Filetype', {
	group = 'EditingHelper',
	pattern = 'java',
	command = [[setlocal expandtab]],
})

-- LSP and File
vim.cmd(':au BufRead,BufEnter *.component.html set filetype=angular')

vim.keymap.set('n', '<leader>cA', function()
	vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
end, { desc = '[C]ode [A]ction' })

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })

vim.api.nvim_create_user_command('F', function(_)
	-- local range = nil
	-- if args.count ~= -1 then
	-- 	local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
	-- 	range = {
	-- 		start = { args.line1, 0 },
	-- 		["end"] = { args.line2, end_line:len() },
	-- 	}
	-- end
	require("conform").format({ async = false, lsp_fallback = true })
end, { desc = 'Format current buffer with conform and LSP fallback' })
-- end LSP and File

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.wo.signcolumn = 'yes'

vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

-- requires telescope
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'TelescopeResults',
	callback = function(ctx)
		vim.api.nvim_buf_call(ctx.buf, function()
			vim.fn.matchadd('TelescopeParent', '\t\t.*$')
			vim.api.nvim_set_hl(0, 'TelescopeParent', { link = 'Comment' })
		end)
	end,
})
-- end telescope requirement
