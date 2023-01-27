local M = {}

local lspkind = require 'lspkind'
local compare = require 'cmp.config.compare'
local status, tabnine = pcall(require, 'cmp_tabnine')

function tabnine_compare_fn()
  if status then
    return require('cmp_tabnine.compare')
  end
end

local source_mapping = {
  nvim_lsp = "[Lsp]",
  luasnip = "[Snip]",
  buffer = "[Buffer]",
  path = '[Path]',
  nvim_lsp_signature_help = "[Signature]",
  cmp_tabnine = "[TNine]"
}

function M.setup()
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
  end

  local luasnip = require 'luasnip'
  local cmp = require 'cmp'

  cmp.setup {
		 completion = { completeopt = "menu,menuone,noinsert,noselect", keyword_length = 1 },
    --experimental = { native_menu = false, ghost_text = false },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    -- sorting = {
    --   priority_weight = 2,
    --   comparators = {
    --     tabnine_compare_fn(),
    --     compare.score,
    --     compare.recently_used,
    --     compare.offset,
    --     compare.exact,
    --     compare.kind,
    --     compare.sort_text,
    --     compare.length,
    --     compare.order,
    --   },
    -- },
    -- formatting = {
    --   format = function(entry, vim_item)
    --     vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
    --
				-- -- Source
    --     vim_item.menu = ({
    --       luasnip = '[Snip]',
				-- 	nvim_lsp = '[LSP]',
    --       buffer = '[Buffer]',
				-- 	path = '[Path]',
				--   nvim_lsp_signature_help = "[Signature]",
    --       cmp_tabnine = "[TNine]"
    --       --treesitter = '[Treesitter]',
    --     })[entry.source.name]
    --     return vim_item
    --   end,
    -- },
    formatting = {
      format = lspkind.cmp_format {
        mode = 'symbol_text',
        maxwidth = 40,

        before = function (entry, vim_item)
          vim_item.kind = lspkind.presets.default[vim_item.kind]
          local menu = source_mapping[entry.source.name]
          if entry.source.name == "cmp_tabnine" then
            if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
              menu = entry.completion_item.data.detail .. " " .. menu
            end
            vim_item.kind = ""
          end
          vim_item.menu = menu
          return vim_item
        end,
      }
    },
    mapping = {
      ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping { i = cmp.mapping.close(), c = cmp.mapping.close() },
			['<CR>'] = cmp.mapping.confirm({select = true}),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        'i',
        's',
        'c',
      }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        'i',
        's',
        'c',
      }),
    },
    sources = {
			{ name = "nvim_lsp", max_item_count = 15},
		  { name = 'nvim_lsp_signature_help', max_item_count = 5 },
      { name = 'buffer', max_item_count = 5 },
      { name = 'luasnip', max_item_count = 5 },
      { name = 'path' },
      { name = "cmp_tabnine", max_item_count = 5 },
      --{ name = 'spell' },
      --{ name = 'emoji' },
      --{ name = 'calc' },
    },
		window = {
       completion = { -- rounded border; thin-style scrollbar
      border = 'rounded',
      scrollbar = '║',
    },
    documentation = {
      border = 'rounded',
      --border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
      --winhighlight = 'NormalFloat:NormalFloat,FloatBorder:TelescopeBorder',
    },
		},
  }

  -- Use buffer source for `/`
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' },
    },
  })

  -- Use cmdline & path source for ':'
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline'},
    }),
  })

  -- auto pair
	local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
end


return M
