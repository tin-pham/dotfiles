return {
	'yetone/avante.nvim',
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = vim.fn.has('win32') ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
		or 'make',
	event = 'VeryLazy',
	version = false,
	---@module 'avante'
	---@type avante.Config
	opts = {
		provider = 'gemini',
		-- FIXED: Move 'gemini' config inside 'providers'
		providers = {
			gemini = {
				model = 'gemini-2.5-flash', -- Note: '2.5' doesn't exist yet, likely '1.5-flash' or '2.0-flash-exp'
				temperature = 0,
				max_tokens = 4096,
			},
		},
	},
	dependencies = {
		'nvim-lua/plenary.nvim',
		'MunifTanjim/nui.nvim',
		'nvim-mini/mini.pick',
		'nvim-telescope/telescope.nvim',
		'hrsh7th/nvim-cmp',
		'ibhagwan/fzf-lua',
		'stevearc/dressing.nvim',
		'folke/snacks.nvim',
		'nvim-tree/nvim-web-devicons',
		'zbirenbaum/copilot.lua',
		{
			'HakonHarnes/img-clip.nvim',
			event = 'VeryLazy',
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					use_absolute_path = true,
				},
			},
		},
		{
			'MeanderingProgrammer/render-markdown.nvim',
			opts = {
				file_types = { 'markdown', 'Avante' },
			},
			ft = { 'markdown', 'Avante' },
		},
	},
}
