return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {
			update_focused_file = { enable = true },
			filters = {
				git_ignored = false,
				custom = {
					'\\.git$',
					'node_modules'
				}
			},
			actions = {
				open_file = {
					quit_on_open = true
				}
			}
		}
	end,
	keys = function()
		return {
			{ "<leader>nt", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Neotree" },
		}
	end,
}
