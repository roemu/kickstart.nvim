return {
	'stevearc/oil.nvim',
	keys = {
		{ "<leader>op", "<cmd>Oil --float<cr>", desc = "Open Oil in parent directory" },
	},
	opts = {
		default_file_explorer = true,
		view_options = {
			show_hidden = true
		}
	},
}
