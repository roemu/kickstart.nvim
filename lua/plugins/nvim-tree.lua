return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		renderer = {
			add_trailing = true,
			group_empty = true
		},
		view = {
			width = {}
		},
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
	},
	keys = {
		{ "<leader>nt", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Neotree" },
	},
}
