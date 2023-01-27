local M = {}

function M.setup()
	local status_ok, alpha = pcall(require, 'alpha')
	if not status_ok then
		return
	end

	local dashboard = require('alpha.themes.dashboard')
	--
	dashboard.section.header.val = {
		[[@@@@@@#5?!^::^~7YG&@@@@@@@@@@@]],
		[[@@@&P!:        .:^!JP#@@@@@@@@]],
		[[@@P~          .::::^~!?P&@@@@@]],
		[[@Y.         .^~!77^^~~~~!Y#@@@]],
		[[B!.        :!J5JJP7^~~~!!~^J&@]],
		[[&Y!~:.      .~??7~^^~~~!!!!::G]],
		[[@@B5?!~^:.     ..:^^~~~!!77~ ~]],
		[[@@@@@#5~.    ..::^^~~~!!!~..~J]],
		[[@@@@B?:     ..:::^^~~!!^..^?P@]],
		[[@@G!       ..:::^~~~^:.:~JG&@@]],
		[[&?       ...::^^^^:..^75B&@@@@]],
		[[7    ....::::::..:~?YG#@@@@@@@]],
		[[7. .....:....:~7J5G#@@@@@@@@@@]],
		[[#J~::::^^~!?Y5GB&@@@@@@@@@@@@@]],
		[[@&BP5555PGB#&@@@@@@@@@@@@@@@@@]],
	}

	dashboard.section.buttons.val = {
		dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
		dashboard.button('c', '  Configuration', ':e $MYVIMRC <CR>'),
		dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
	}

	local function footer()
		-- Number of plugins
		local total_plugins = require('lazy').stats().count
		local datetime = os.date('%d-%m-%Y  %H:%M:%S')
		local plugins_text = '\t' .. total_plugins .. ' plugins  ' .. datetime

		-- Quote
		local fortune = require('alpha.fortune')
		local quote = table.concat(fortune(), '\n')

		return plugins_text .. '\n' .. quote
	end

	dashboard.section.footer.val = footer()

	dashboard.section.footer.opts.hl = 'Constant'
	dashboard.section.header.opts.hl = 'Include'
	dashboard.section.buttons.opts.hl = 'Function'
	dashboard.section.buttons.opts.hl_shortcut = 'Type'
	dashboard.opts.opts.noautocmd = true

	alpha.setup(dashboard.opts)
end

return M
