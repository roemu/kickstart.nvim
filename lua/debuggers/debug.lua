return {
	'mfussenegger/nvim-dap',
	event = "VeryLazy",
	dependencies = {
		'williamboman/mason.nvim',
		'jay-babu/mason-nvim-dap.nvim',
	},
	config = function()
		local dap = require 'dap'

		require('mason-nvim-dap').setup {
			automatic_setup = true,
			handlers = {},
			ensure_installed = {
				'javatest',
				'javadbg',
				'delve',
			},
		}

		dap.configurations.java = {
			{
				type = "java",
				name = "Attach to the process",
				request = "attach",
				hostName = "localhost",
				port = "5005"
			}
		}

		---@diagnostic disable-next-line: unused-function, lowercase-global
		function show_dap_centered_scopes()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.scopes)
		end

		vim.keymap.set('n', '<leader>dv', ':lua show_dap_centered_scopes()<CR>', { desc = "Debug: show variables" })
		vim.keymap.set('n', '<leader>ds', dap.continue, { desc = 'Debug: Start' })
		vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
		vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step Over' })
		vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Debug: Step Out' })

		vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
		vim.keymap.set('n', '<leader>B', function()
			dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
		end, { desc = 'Debug: Toggle Breakpoint with condition' })
	end,
}
