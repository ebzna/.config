
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false
-- disable defualt neovim statusline
-- vim.o.ls = 0
vim.o.background = 'dark'
vim.o.ignorecase = true
vim.o.guicursor = 'n-v-c:block,i:hor1'
vim.keymap.set("n", ";p", vim.cmd.Ex)

vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use 'ellisonleao/gruvbox.nvim'
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

	use 'folke/tokyonight.nvim'
	require('tokyonight').setup({ 
		style = 'night', 
		styles = {
			comments = { italic = false },
    		keywords = { italic = false },
		},
		transparent = true,
		on_colors = function(colors) colors.fg = "#ffffff" end
	})

	use 'nvim-treesitter/nvim-treesitter'
	require'nvim-treesitter.configs'.setup {
	  ensure_installed = { 
		  "c",
		  "lua",
		  "vim",
		  "vimdoc",
		  "rust",
		  "javascript",
		  "typescript",
		  "go",
		  "python",
	  },
	  sync_install = false,
	  auto_install = true,
	  ignore_install = {},
	  highlight = {
		enable = true,
		disable = {},
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then return true end
		end,
		additional_vim_regex_highlighting = false,
	  },
	}

	use	'christoomey/vim-tmux-navigator'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-lua/plenary.nvim'
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', ';o', builtin.find_files, {})
	vim.keymap.set('n', ';l', builtin.live_grep, {})
	vim.cmd('colorscheme tokyonight')
end)
