vim.keymap.set("n", ";p", vim.cmd.Ex)
vim.o.relativenumber = true
vim.o.tabstop = 4		-- tabs length displayed
vim.o.shiftwidth = 4	-- tabs length on TAB
vim.o.wrap = false
vim.o.background = 'dark'
vim.o.ignorecase = true
vim.o.guicursor = 'n-v-c:block,i:hor1'
vim.o.ls = 0	-- disable default neovim statusline
vim.o.scl='no'	-- disable diagnostics sign column

vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
	use {
		'wbthomason/packer.nvim',
		'nvim-treesitter/nvim-treesitter',
		'christoomey/vim-tmux-navigator',
		'nvim-telescope/telescope.nvim',
		'nvim-lua/plenary.nvim',
	}
	use {
		'ellisonleao/gruvbox.nvim',
		'folke/tokyonight.nvim',
		'rose-pine/neovim',
		'olivercederborg/poimandres.nvim',
		'craftzdog/solarized-osaka.nvim',
	}
	use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
	    {'williamboman/mason.nvim'},
		{'williamboman/mason-lspconfig.nvim'},
	    {'neovim/nvim-lspconfig'},
	    {'hrsh7th/nvim-cmp'},
		{'hrsh7th/cmp-nvim-lsp'},
		-- TODO: find out how to write custom snippets/per/language
		--
		-- https://github.com/L3MON4D3/LuaSnip
		{'L3MON4D3/LuaSnip'},
	  }
	}

	require('gruvbox').setup({
		transparent_mode = true ,
		italic = {
			strings = false,
			emphasis = false,
			comments = false,
			operators = false,
			folds = false
		},
	})
	require('tokyonight').setup({
		style = 'night',
		styles = {
			comments = {
				italic = false
			},
			keywords = {
				italic = false
			}
		},
		transparent = true,
		on_colors = function(colors) colors.fg = "#ffffff" end
	})
	require('poimandres').setup {
		disable_background = true,
		disable_italics = true,
	}
	require('rose-pine').setup({
		styles = {
			italic = false,
        	transparency = true,
    	},
	})
	require('solarized-osaka').setup({
		transparent = true,
		styles = {
    		comments = {
				italic = true
			},
    		keywords = {
				italic = true
			},
		},
	})
	vim.cmd('colorscheme gruvbox')

	require'nvim-treesitter.configs'.setup {
	  ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "typescript", "bash" },
	  sync_install = false,
	  auto_install = true,
	  ignore_install = {},
	  highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then return true end
		end,
		additional_vim_regex_highlighting = false,
	  },
	}

	local builtin = require('telescope.builtin')
	vim.keymap.set('n', ';o', builtin.find_files, {})
	vim.keymap.set('n', ';l', builtin.live_grep, {})

	local lsp_zero = require('lsp-zero')

	lsp_zero.on_attach(function(client, bufnr)
	  lsp_zero.default_keymaps({buffer = bufnr})
	end)

	require('mason').setup({})
	require('mason-lspconfig').setup({
	  ensure_installed = {},
	  handlers = {
	    lsp_zero.default_setup,
		lua_ls = function ()
			require('lspconfig').lua_ls.setup({
				settings = {
					Lua = {
      					diagnostics = { globals = { 'vim', 'require' } },
					}
				}
			})
		end,
	  },
	})

	local cmp = require('cmp')
	local cmp_action = require('lsp-zero').cmp_action()

	cmp.setup({
	  mapping = cmp.mapping.preset.insert({
	    -- `Enter` key to confirm completion
	    ['<CR>'] = cmp.mapping.confirm({select = false}),
	    -- Ctrl+Space to trigger completion menu
	    ['<C-Space>'] = cmp.mapping.complete(),
	    -- Navigate between snippet placeholder
	    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
	    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
	    -- Scroll up and down in the completion documentation
	    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
	    ['<C-d>'] = cmp.mapping.scroll_docs(4),
	  })
	})
end)
