return {
	-- Git related plugins
	'tpope/vim-fugitive',

	-- Useful plugin to show you pending keybinds.
	{
		'folke/which-key.nvim',
		opts = {
			delay = 1000
		},
		event = "BufEnter"
	},
	{ 'numToStr/Comment.nvim', opts = {},             event = "VeryLazy" },
	{
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		main = 'ibl',
		opts = {},
		event = "BufEnter"
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		event = "BufEnter",
		opts = {},
	},
	{ 'towolf/vim-helm',       ft = { 'yaml', 'yml' } },
	{ 'apple/pkl-neovim',      ft = { 'pkl' } },
	{
		'lucidph3nx/nvim-sops',
		event = 'BufEnter',
		opts = {},
		ft = { 'json', 'yaml', 'yml' }
	},
}
