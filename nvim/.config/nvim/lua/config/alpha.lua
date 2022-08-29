local M = {}

function M.setup()
  local status_ok, alpha = pcall(require, 'alpha')
  if not status_ok then
    return
  end

  local dashboard = require 'alpha.themes.dashboard'
  local function header()
    return {
	[[@@@@@@@@@@@@&B5J?!~~^~~!?YPB#@@@@@@@@@@@@@@@@@@@@@]]
	[[@@@@@@@@@B57^.         ..:^~7J5B&@@@@@@@@@@@@@@@@@]]
	[[@@@@@@#57:              ...::^^!7JP#@@@@@@@@@@@@@@]]
	[[@@@@#Y~.                ....:::^^~~!?P#@@@@@@@@@@@]]
	[[@@@P!.                  ::^::::^^^~~~~!JG&@@@@@@@@]]
	[[@&Y~                 .^^^!77!!:^^^~~~~~~~!5#@@@@@@]]
	[[@5!:              :::!??7777YPJ^^^~~~~~!!~^^J#@@@@]]
	[[&?!~.             .~7?YPP5J?PPJ^^^~~~~~!!!!~::J&@@]]
	[[@P77!~^..           .^7YPP5J7~:^^^~~~~!!!!!7!^ :P@]]
	[[@@GJ77!!~^:..           ..:.::^^^~~~~~!!!!!777: .P]]
	[[@@@@B5J?7!!~^:..       ....:::^^^~~~~~!!!!!77!. .7]]
	[[@@@@@@@#G5J?7~:.       ...:::^^^~~~~~!!!!!7!^  :!?]]
	[[@@@@@@@@@@#?.         ...::::^^^~~~~~!!!!~:  .~7?B]]
	[[@@@@@@@@G!.         ....::::^^^~~~~~!!!~:  .~7?5&@]]
	[[@@@@@&Y^           ....::::^^^~~~~!!~^.  :!?J5#@@@]]
	[[@@@&J:           .....::::^^^~~~~~^.  .~7?YP&@@@@@]]
	[[@@5:           .....::::^^^^~~~^.  .^7?J5B&@@@@@@@]]
	[[&7          ......::::^^^^^^:.  .^7JJYG#@@@@@@@@@@]]
	[[J       .......:::::^^^^:.   :~?JY5P#@@@@@@@@@@@@@]]
	[[?.  ........:::::::::.   :~7JYY5G#@@@@@@@@@@@@@@@@]]
	[[57.  ...::::::...   .^~7JYY5PG#@@@@@@@@@@@@@@@@@@@]]
	[[&5J~:.      ..::~!?JYY55PG#&@@@@@@@@@@@@@@@@@@@@@@]]
	[[@@BPYJJ???JJYYY5555PGB#&@@@@@@@@@@@@@@@@@@@@@@@@@@]]
	[[@@@@#BGPP555PPPGB#&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@]]
    }
  end

  dashboard.section.header.val = header()

  dashboard.section.buttons.val = {
    dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
    dashboard.button('c', '  Configuration', ':e $MYVIMRC <CR>'),
    dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
  }

  local function footer()
    -- Number of plugins
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date '%d-%m-%Y  %H:%M:%S'
    local plugins_text = '\t' .. total_plugins .. ' plugins  ' .. datetime

    -- Quote
    local fortune = require 'alpha.fortune'
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








