local M = {}

function M.setup()
	--local packer_bootstrap = false

	-- lazy.nvim configuration

	-- Check if lazy.nvim is installed
	---- Run PackerCompile if there are changes in this file
	local function lazy_init()
		local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
		if not vim.loop.fs_stat(lazypath) then
			vim.fn.system({
				'git',
				'clone',
				'--filter=blob:none',
				'https://github.com/folke/lazy.nvim.git',
				'--branch=stable', -- latest stable release
				lazypath,
			})
		end
		vim.opt.rtp:prepend(lazypath)
	end

	-- 	if packer_bootstrap then
	-- 		print('Restart Neovim required after installation')
	-- 		require('packer').sync()
	-- 	end
	-- end

	lazy_init()
	local lazy = require('lazy')
	--packer.init(conf)

	vim.g.mapleader = ' '
	vim.g.maplocalleader = ' '
	lazy.setup('plugins')

	-- vim.cmd([[
	-- 	augroup packer_user_config
	-- 		autocmd!
	-- 		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	-- 	augroup end
	-- ]])
end

return M
