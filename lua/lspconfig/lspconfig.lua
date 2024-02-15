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
    { 'williamboman/mason-lspconfig.nvim',
    opts = {
        handlers = {
          ["jdtls"] = function ()
            require("java").setup()
          end
        }
      }},
    { 'j-hui/fidget.nvim',       opts = {} },
    'folke/neodev.nvim',
  },
  opts = {
    inlay_hints = { enabled = true }
  },
  config = function()
    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', function()
        vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
      end, '[C]ode [A]ction')

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_create_user_command('Format', function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_fallback = true, range = range })

        -- vim.lsp.buf.format()
      end, { desc = 'Format current buffer with conform and LSP fallback' })
    end

    -- document existing key chains
    require('which-key').register {
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      -- ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
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
      tsserver = {},
      html = { filetypes = { 'html'} },
      angularls = { filetypes = { 'angular', 'typescript' } },
      emmet_ls = { filetypes = { 'html', 'angular', 'scss', 'css' } },
      jdtls = {},
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    }
    -- Setup neovim lua configuration
    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
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
