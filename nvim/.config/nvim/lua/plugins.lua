local M = {}

function M.setup() 
	-- Indicate first time installation
	local packer_bootstrap = false

	-- packer.nvim configuration
	local conf = {
		profile = {
			enable = true,
		 threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		},
		display = {
			open_fn = function()
				return require('packer.util').float({ border = 'rounded'})
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
			-- Module
			use { 'nvim-lua/plenary.nvim', module = 'plenary' } 

			-- UI
				-- Colorscheme
	    use { 
				'rose-pine/neovim',
				config = function()
					vim.cmd 'colorscheme rose-pine'
				end,
	    } 
				-- Better icons 
			use {
				'kyazdani42/nvim-web-devicons',
				module = 'nvim-web-devicons',
				config = function()
					require('nvim-web-devicons').setup { default = true }
				end,
			}
			-- Completion
				-- cmp 
				use { 
					'hrsh7th/nvim-cmp',
					event = 'InsertEnter',
					opt = true,
					config = function()
						require('config.cmp').setup()
					end,
					wants = { 'LuaSnip' },
					requires = {
						{ 
							'L3MON4D3/LuaSnip',
							wants = "friendly-snippets",
							config = function()
								require('config.luasnip').setup()
							end
						},
					 'rafamadriz/friendly-snippets',
					}
				} 
				 use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
			   use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
				 use { 'hrsh7th/cmp_cmdline', after = 'nvim-cmp' }
				 use { 'hrsh7th/cmp-calc', after = 'nvim-cmp' }
				 use { 'hrsh7th/cmp-emoji', after = 'nvim-cmp' }
				 use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
				 use { 'f3fora/cmp-spell', after = 'nvim-cmp' }
				use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }




			-- Tweaks
				-- Whichkey
				use { 
					'folke/which-key.nvim',
					event = 'VimEnter',
					config = function()
						require('config.whichkey').setup()
					end,
				} 
				-- Git
				use { 
					'TimUntersberger/neogit',
					cmd = 'Neogit',
					requires = 'nvim-lua/plenary.nvim',
					config = function()
						require('config.neogit').setup()
					end,
				} 
				-- Better Comment
					use {
						'numToStr/Comment.nvim',
						opt = true,
						keys = { 'gc', 'gcc', 'gbc' },
						config = function()
							require("Comment").setup {}
						end,
					}


	    if packer_bootstrap then
				print 'Restart Neovim required after installation'
				require('packer').sync()
	    end
	end

	local packer = require 'packer'
	packer.init(conf)
	packer.startup(plugins)
end

return M
