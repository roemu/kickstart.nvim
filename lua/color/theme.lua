return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		config = function()
			require("catppuccin").setup()

			vim.cmd.colorscheme "catppuccin"
			vim.api.nvim_set_hl(0, 'LineNr', {fg = '#c0c0c0'})
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		event = "VeryLazy",
		opts = {
			options = {
				icons_enabled = false,
				theme = 'auto',
				component_separators = '|',
				section_separators = '',
			},
		},
	},
}
