return {
	-- Git related plugins
	'tpope/vim-fugitive',

	-- Useful plugin to show you pending keybinds.
	{ 'folke/which-key.nvim',  opts = {} },
	{ 'numToStr/Comment.nvim', opts = {} },
	{
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		main = 'ibl',
		opts = {},
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {},
	},
	{ 'towolf/vim-helm',  ft = { 'yaml', 'yml' } },
	{ 'apple/pkl-neovim', ft = { 'pkl' } },
	{
		'lucidph3nx/nvim-sops',
		event = { 'BufEnter' },
		opts = {},
		ft = { 'json', 'yaml', 'yml' }
	},
}
