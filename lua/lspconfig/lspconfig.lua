return {
	'neovim/nvim-lspconfig',
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
		require('which-key').register {
			['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
			['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
			['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
			['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
			['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
			['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
			['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
		}

		require('which-key').register({
			['<leader>'] = { name = 'VISUAL <leader>' },
			['<leader>h'] = { 'Git [H]unk' },
		}, { mode = 'v' })

		require('mason').setup()
		require('mason-lspconfig').setup()

		local servers = {
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
			bashls = { 'sh' },
			gopls = { 'go' },
			cssls = { 'css', 'scss', 'sass' },
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
