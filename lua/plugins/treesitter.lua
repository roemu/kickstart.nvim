return {
	-- Highlight, edit, and navigate code
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
	},
	build = ':TSUpdate',
	config = function()
		vim.defer_fn(function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = { 'lua', 'rust', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'java', 'angular', 'html', 'scss', 'yaml', 'go'},

				auto_install = false,
				sync_install = false,
				ignore_install = {},

				modules = {},
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
					-- 	init_selection = '<C-space>',
						node_incremental = '<C-space>',
						-- scope_incremental = '<C-s>',
						-- node_decremental = '<M-space>',
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/nvim-treesitter-text-objects.lua
							-- You can use the capture groups defined in textobjects.scm
							-- ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
							-- ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
							-- ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
							-- ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

							-- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
							["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
							["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
							["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
							["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

							["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
							["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

							["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
							["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

							["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
							["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

							["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
							["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

							["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
							["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

							["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							[']m'] = '@function.outer',
							[']]'] = '@class.outer',
						},
						goto_next_end = {
							[']M'] = '@function.outer',
							[']['] = '@class.outer',
						},
						goto_previous_start = {
							['[m'] = '@function.outer',
							['[['] = '@class.outer',
						},
						goto_previous_end = {
							['[M'] = '@function.outer',
							['[]'] = '@class.outer',
						},
					},
					-- swap = {
					--   enable = true,
					--   swap_next = {
					--     ['<leader>a'] = '@parameter.inner',
					--   },
					--   swap_previous = {
					--     ['<leader>A'] = '@parameter.inner',
					--   },
					-- },
				},
			}
		end, 0)
	end
}
