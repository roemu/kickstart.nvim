return {
	'neovim/nvim-lspconfig',
	event = 'VeryLazy',
	dependencies = {
		{
			'williamboman/mason.nvim',
			config = true,
			opts = {
				ensure_installed = {}
			}
		},
		{
			'williamboman/mason-lspconfig.nvim',
			opts = {
			}
		},
		{ 'j-hui/fidget.nvim', lazy = true, opts = {} },
		'folke/neodev.nvim',
	},
	opts = {
		inlay_hints = { enabled = true }
	},
	config = function()
		local on_attach = function(_, _)
			-- Create a command `:Format` local to the LSP buffer
		end

		-- document existing key chains
		require("which-key").add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>g", group = "[G]it" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>h", group = "Git [H]unk" },
			},
			{
				mode = { "v", "n" },
				{ "<leader>", 'VISUAL <leader>' },
			}
		)

		require('mason').setup()
		require('mason-lspconfig').setup()

		local servers = {
			helm_ls = { filetypes = { 'helm' } },
			rust_analyzer = {},
			jsonls = { filetypes = { 'json' } },
			yamlls = {
				filetypes = { 'yaml' },
				yaml = {
					validate = true,
					schemaStore = {
						enable = false,
						url = "",
					},
					schemas = {
						['https://clew-resources.sbb-cloud.net/tekton-schema.json'] = 'estaTektonPipeline.{yaml,yml}',
					}
				},
			},
			tsserver = {},
			bashls = { filetypes = { 'sh' } },
			gopls = { filetypes = { 'go' } },
			cssls = { filetypes = { 'css', 'scss', 'sass' } },
			html = { filetypes = { 'html' } },
			angularls = { filetypes = { 'angular', 'typescript' } },
			emmet_ls = { filetypes = { 'html', 'angular', 'scss', 'css' } },
			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
			jdtls = { filetypes = { 'java' } },
		}
		-- Setup neovim lua configuration
		require('neodev').setup()

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		-- Ensure the servers above are installed
		local mason_lspconfig = require 'mason-lspconfig'

		mason_lspconfig.setup {
			ensure_installed = vim.tbl_keys(servers),
		}

		mason_lspconfig.setup_handlers {
			function(server_name)
				if server_name == "jdtls" then
					return
				end
				require('lspconfig')[server_name].setup {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				}
			end,
		}
	end
}
