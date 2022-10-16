local M = {}

function M.setup()
	local packer_bootstrap = false

	-- packer.nvim configuration
	local conf = {
		profile = {
			enable = true,
			threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		}, display = {
			open_fn = function()
				return require('packer.util').float({ border = 'rounded' })
			end
		}
	}
	-- Check if packer.nvim is installed
	-- Run PackerCompile if there are changes in this file
	local function packer_init()
		local fn = vim.fn
		local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
		if fn.empty(fn.glob(install_path)) > 0 then
			packer_bootstrap = fn.system {
				'git',
				'clone',
				'--depth',
				'1',
				'https://github.com/wbthomason/packer.nvim',
				install_path,
			}
			vim.cmd [[packadd packer.nvim]]
		end
		vim.cmd 'autocmd BufWritePost plugins.lua source <afile> | PackerCompile'
	end

	local function plugins(use)
		use { 'wbthomason/packer.nvim' }
    use { "lewis6991/impatient.nvim" }
		-- Module
		use { 'nvim-lua/plenary.nvim', module = 'plenary' }

		-- UI
		-->Colorscheme
		use {
			'rose-pine/neovim',
			config = function()
				require('config.rose-pine').setup()
			end,
		}
		-->Better icons
		use {
			'kyazdani42/nvim-web-devicons',
			module = 'nvim-web-devicons',
			config = function()
				require('config.web-devicons').setup()
			end,
		}
		-->Syntax Highlight
		use {
			'nvim-treesitter/nvim-treesitter',
			opt = true,
			event = 'BufRead',
			run = ':TSUpdate',
			config = function()
				require('config.treesitter').setup()
			end,
		}
		-- Auto Complete
		-->cmp
		use {
			'hrsh7th/nvim-cmp',
			event = 'InsertEnter',
			opt = true,
			wants = { 'LuaSnip' },
			config = function()
				require('config.cmp').setup()
			end,
			requires = {
				'hrsh7th/cmp-buffer',
				'hrsh7th/cmp-path',
				'hrsh7th/cmp-cmdline',
				'saadparwaiz1/cmp_luasnip',
				'hrsh7th/cmp-calc',
				'f3fora/cmp-spell',
				'hrsh7th/cmp-emoji',
				'hrsh7th/cmp-nvim-lsp-signature-help',

			}
		}

		use {
			'hrsh7th/cmp-nvim-lsp',
			after = { 'nvim-cmp', 'nvim-lspconfig' },
			requires = {
				'hrsh7th/nvim-cmp',
				'neovim/nvim-lspconfig'
			}
		}
		use {
			'L3MON4D3/LuaSnip',
			opt = true,
			after = 'cmp_luasnip',
			wants = 'friendly-snippets',
			requires = { 'rafamadriz/friendly-snippets' },
			config = function()
				require('config.luasnip').setup()
			end
		}

		-->Autopair
		use {
			'windwp/nvim-autopairs',
			module = { 'nvim-autopairs.completion.cmp', 'nvim-autopairs' },
			wants = 'nvim-treesitter',
			requires = 'nvim-treesitter/nvim-treesitter',
			config = function()
				require('config.autopairs').setup()
			end,
		}

		-->Autotag
		use {
			'windwp/nvim-ts-autotag',
			event = 'InsertEnter',
			requires = 'nvim-treesitter/nvim-treesitter',
			after = 'nvim-treesitter',
			-- This plugin enable in treesitter
		}
		-->End wise
		use {
			'RRethy/nvim-treesitter-endwise',
			event = 'InsertEnter',
			requires = 'nvim-treesitter/nvim-treesitter',
			wants = 'nvim-treesitter',
			-- This plugin enable in treesitter
		}
		--> Language Server
		----> LSP
		use {
			'neovim/nvim-lspconfig',
       event = { "BufReadPre" },
			wants = { 'mason.nvim', 'mason-lspconfig.nvim', 'mason-tool-installer.nvim', 'cmp-nvim-lsp', 'neodev.nvim',
				'vim-illuminate', 'null-ls.nvim', 'schemastore.nvim' },
			requires = {
				'williamboman/mason.nvim',
				'williamboman/mason-lspconfig.nvim',
				'WhoIsSethDaniel/mason-tool-installer.nvim',
				'hrsh7th/cmp-nvim-lsp',
				'folke/neodev.nvim',
				'RRethy/vim-illuminate',
				'jose-elias-alvarez/null-ls.nvim',
        'b0o/schemastore.nvim',
			},
			config = function()
				require('config.lsp').setup()
			end
		}
		----> Trouble
		use {
			'folke/trouble.nvim',
			event = 'BufReadPre',
			wants = 'nvim-web-devicons',
			cmd = { 'TroubleToggle', 'Trouble' },
			config = function()
				require('trouble').setup {
					use_diagnostic_signs = true
				}
			end
		}

		---> LSP Saga
		use {
			'tami5/lspsaga.nvim',
			event = 'VimEnter',
			cmd = { 'Lspsaga' },
			config = function()
				require('lspsaga').setup {}
			end
		}


		-- Addon
    --> Startup Screen
        use {
           "goolord/alpha-nvim",
           config = function()
              require("config.alpha").setup()
           end,
        }
		--> Telescope
		use {
			'nvim-telescope/telescope.nvim',
			cmd = { 'Telescope' },
			module = 'telescope',
			keys = { '<leader>f', '<leader>p' },
			wants = { 'plenary.nvim', 'popup.nvim', 'telescope-fzf-native.nvim', 'telescope-file-browser.nvim' },
			requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim',
				{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }, 'nvim-telescope/telescope-file-browser.nvim' },
			config = function()
				require('config.telescope').setup({
         background_colour = "#000000"
        })
			end
		}
    --> Notify
    use {
       'rcarriga/nvim-notify',
      event = "VimEnter",
      config = function()
        require('config.nvim-notify').setup()
        vim.notify = require 'notify'
      end,
    }
    --> Neoscroll
    use {
      'karb94/neoscroll.nvim',
      event = 'VimEnter',
      config = function()
        require('config.neoscroll').setup()
      end
    }
    --> Nvimtree
          use {
       "kyazdani42/nvim-tree.lua",
       requires = {
         "kyazdani42/nvim-web-devicons",
       },
       cmd = { "NvimTreeToggle", "NvimTreeClose" },
         config = function()
           require("config.nvimtree").setup()
         end,
      }


		-- Tweaks
		--> Whichkey
		use {
			'folke/which-key.nvim',
			event = 'VimEnter',
			config = function()
				require('config.whichkey').setup()
			end,
		}
		--> Git
		use {
			'TimUntersberger/neogit',
			cmd = 'Neogit',
			requires = 'nvim-lua/plenary.nvim',
			config = function()
				require('config.neogit').setup()
			end,
		}
		--> Better Comment
		use {
			'numToStr/Comment.nvim',
			opt = true,
			keys = { 'gc', 'gcc', 'gbc' },
			config = function()
				require('Comment').setup {}
			end,
		}
    --> Better Winbar
    use {
      'fgheng/winbar.nvim',
      event = 'BufRead',
      wants = 'nvim-web-devicons',
      config = function ()
        require('config.winbar').setup()
      end
    }

		if packer_bootstrap then
			print 'Restart Neovim required after installation'
			require('packer').sync()
		end
	end

	local packer = require 'packer'
	packer.init(conf)
	packer.startup(plugins)

	vim.cmd [[
		augroup packer_user_config
			autocmd!
			autocmd BufWritePost plugins.lua source <afile> | PackerSync 
		augroup end
	]]
end

return M
