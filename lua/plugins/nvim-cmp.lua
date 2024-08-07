local M = {
	'hrsh7th/nvim-cmp',
	event = "VeryLazy",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{ 'L3MON4D3/LuaSnip',             lazy = true, event = "VeryLazy" },
		{ 'saadparwaiz1/cmp_luasnip',     lazy = true, event = "VeryLazy" },

		-- Adds LSP completion capabilities
		{ 'hrsh7th/cmp-nvim-lsp',         lazy = true, event = "VeryLazy" },
		{ 'hrsh7th/cmp-path',             lazy = true, event = "VeryLazy" },

		-- Adds a number of user-friendly snippets
		{ 'rafamadriz/friendly-snippets', lazy = true, event = "VeryLazy" },
	},
}

M.config = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/snippets" } })
	vim.opt.completeopt = { "menu", "menuone", "noinsert" }

	cmp.setup {
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert {
			['<C-n>'] = cmp.mapping.select_next_item(),
			['<C-p>'] = cmp.mapping.select_prev_item(),
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete {},
			['<C-y>'] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			},
			['<C-l>'] = cmp.mapping(function()
				if luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { 'i', 's' }),
			['<C-h>'] = cmp.mapping(function()
				if luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { 'i', 's' }),
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			{ name = 'path' },
		},
	}
	--
	-- cmp.setup.cmdline(":", {
	-- 	mapping = cmp.mapping.preset.cmdline(),
	-- 	sources = cmp.config.sources({
	-- 		{ name = "path" },
	-- 	}, {
	-- 		{ name = "cmdline" },
	-- 	}),
	-- })
end

return M
