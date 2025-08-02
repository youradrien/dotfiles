vim.opt.updatetime = 1

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.virtualedit = 'onemore'

-- Sets how neovim will display certain whitespace characters in the editor.
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

vim.o.mouse = 'a'
vim.opt.showmode = false      -- Hide -- INSERT -- etc.

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.lazyredraw = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 4
vim.o.number = true
vim.opt.signcolumn = "yes:1"  -- or "yes:2" for 2 columns wide

-- J.
vim.o.scroll = 1 -- Scroll by 1 line at a time
vim.o.mousescroll = 'ver:1'
vim.cmd [[highlight Normal guibg=NONE]]

-- [[ Basic Keymaps ]]
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
--
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.opt.showmode = false

-- highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost',
  {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
})


-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)



-- here is where you install your plugins.
require('lazy').setup
{
  -- sleuth: detect tabstop, shiftwidth automatically
  'tpope/vim-sleuth',

  -- cursorline: underline SELECTED VARIABLES
  --'ya2s/nvim-cursorline',

  -- illuminate: gitsigns [+, -, `]`]
  'RRethy/vim-illuminate',
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '_' },
        topdelete    = { text = '' },
        changedelete = { text = '' },
        untracked    = { text = '' },
      },
      signcolumn = true, -- Keep signcolumn on so the '+' shows up
    }
  },



  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },


  -- bufferline (windows tabs)
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          mode = 'buffers', -- "tabs" is also available
          diagnostics = 'nvim_lsp',
          show_buffer_close_icons = true,
          show_close_icon = false,
          separator_style = 'thick', -- "slant" | "thick" | "thin" | { 'left', 'right' }
          offsets = {
            {
              filetype = "neo-tree",
              text = "Neo-tree", -- optional title in the offset
              text_align = "left", -- or "center", "right"
              separator = true, -- adds a vertical separator between Neo-tree and buffers
              padding = 1,
            }
          },
        },
      }
    end,
  },



  -- telescope (fuzzy Finder (files, lsp, etc))
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },

    config = function()
      -- [[ Configure Telescope ]]
      require('telescope').setup {
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    end,
  },


  -- LSP plugins
  {
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- LSP configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim', opts = {} },

      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.).       --
      -- LSP provides Neovim with features like:
      --  - Go to definition, find references, autocompletion, symbol Search and more...
      --
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })
      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --  Add any additional override configuration in the following tables. Available keys are:
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        clangd = {
          settings = {
            c = {
              completion = {
                callSnipper = 'Replace',
              },
            },
            cpp = {
              completion = {
                callSnipper = 'Replace',
              },
            },
          },
        },
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        lua_ls = {
          -- cmd = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', 
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup{
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },


  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          -- Accept ([y]es) the completion.
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          -- ['<CR>'] = cmp.mapping.confirm { select = true },
          -- ['<C-Space>'] = cmp.mapping.complete {},
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
          {
            name = 'lazydev',
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },


  -- nvim colorscheme
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
    end,
  },


  -- lualine 
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
        require('lualine').setup({
          options = {
              theme = 'default', -- or 'onedark', 'tokyonight', 'catppuccin'
              -- section_separators = '',
              component_separators = '',
                -- Remove bold/italic styles
              disabled_filetypes = {},
              globalstatus = true,
          },
          --sections = {
            --lualine_a = { { 'mode', fmt = function(str) return str:lower() end } },
            --lualine_b = { 'branch' },
            --lualine_c = { 'filename' },
            --lualine_x = {},
            --lualine_y = { 'filetype' },
            --lualine_z = { 'location' },
          --},
        })
    end
  },


  -- smooth sroll
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({
          respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
          cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
          easing = "linear",
          -- duration_multiplier = 20.0,   -- Global duration multiplier

      })
    end
  },


  -- mini.nvim
  {
    'echasnovski/mini.nvim',
    config = function()
      -- better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }
      -- add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.surround').setup()
      require('mini.pairs').setup()
      require('mini.map').setup()
      -- require('mini.indentscope').setup()
    end,
  },

  -- highlight code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 
        'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 
        'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'javascript' 
      },
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },


  -- colored indented parentheses
  {
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
        },
        query = {
          [''] = 'rainbow-delimiters',
        },
        highlight = {
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          -- 'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },


  -- treesitter context 
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        enable = false,
        max_lines = 1,
        mode = 'cursor',
        multiline_threshold = 20,
        separator = nil, -- disable dashed line under context
        zindex = 20,
      }
    end,
  },

  -- nvim scrollbar
  --{
  --  'petertriho/nvim-scrollbar',
  --  config = function()
  --  require("scrollbar").setup()
  --  end
  --},

  -- scrollbar 
  --{
  --  'Xuyuanp/scrollbar.nvim',
    -- no setup required
  --  init = function()
  --      local group_id = vim.api.nvim_create_augroup('scrollbar_init', { clear = true })

  --      vim.api.nvim_create_autocmd({ 'BufEnter', 'WinScrolled', 'WinResized' }, {
  --          group = group_id,
  --          desc = 'Show or refresh scrollbar',
  --          pattern = { '*' },
  --          callback = function()
  --              require('scrollbar').show()
  --          end,
  --      })
  --  end,
  --},

  -- following comments only work if you have downloaded the kickstart repo.
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree', <--- my own
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x", -- or "v2.x" if you prefer stable
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        sources = { "filesystem", "buffers", "git_status" },
        default_component_configs = {
          indent = {
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            indent_size = 2,
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
          },
          git_status = {
            symbols = {
              added     = "A",
              modified  = "M",
              deleted   = "D",
              renamed   = "R",
              untracked = "U",
              ignored   = "I",
              unstaged  = "✗",
              staged    = "✓",
              conflict  = "!",
            }
          },
        },
        window = {
          position = "left",
          width = 30,
          mappings = {
            ["<space>"] = "toggle_node",
            ["<cr>"] = "open",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["a"] = "add",
            ["d"] = "delete",
            ["r"] = "rename",
            ["c"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["q"] = "close_window",
          }
        },
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = true,
          },
          follow_current_file = {
            enabled = true,
          },
          use_libuv_file_watcher = true,
        },
      })
    end
  }
}

vim.cmd [[highlight Normal guibg=NONE]]

vim.cmd [[highlight SignColumn guibg=NONE]]
-- neo-tree background transparent
vim.cmd [[highlight NeoTreeNormal guibg=NONE]] -- Transparent background for Neo-tree's main window
vim.cmd [[highlight NeoTreeNormalNC guibg=NONE]] -- Transparent background for Neo-tree's non-current window
vim.cmd [[highlight NeoTreeIndentMarker guibg=NONE]] -- Transparent background for Neo-tree's indent markers
vim.cmd [[highlight NeoTreeRootName guibg=NONE]] -- Transparent background for Neo-tree's root name
vim.cmd [[highlight NeoTreeTabActive guibg=NONE]] -- Transparent background for Neo-tree's active tab
vim.cmd [[highlight NeoTreeTabInactive guibg=NONE]] -- Transparent background for Neo-tree's inactive tab
vim.cmd [[highlight NeoTreeWinSeparator guibg=NONE guifg=NONE]] -- Transparent background for Neo-tree window separator

-- Reapply transparency whenever focus changes between windows
vim.cmd [[autocmd WinEnter,WinLeave * highlight Normal guibg=NONE]]
vim.cmd [[autocmd WinEnter,WinLeave * highlight StatusLine guibg=NONE]]
vim.cmd [[autocmd WinEnter,WinLeave * highlight StatusLineNC guibg=NONE]]
vim.cmd [[
  highlight NvimTreeNormal guibg=NONE ctermbg=NONE
  highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
  highlight NvimTreeEndOfBuffer guibg=NONE ctermbg=NONE
]]


vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.cmd [[
      highlight Normal guibg=NONE ctermbg=NONE
      highlight NvimTreeNormal guibg=NONE ctermbg=NONE
      highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
      highlight NvimTreeEndOfBuffer guibg=NONE ctermbg=NONE
    ]]
  end,
})


-- bufferline transparency
vim.api.nvim_set_hl(0, 'BufferLineFill', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineBackground', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineBufferSelected', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineBufferVisible', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineTabSelected', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineTab', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineTabClose', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineCloseButton', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineCloseButtonSelected', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineSeparator', { bg = 'NONE', fg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineSeparatorSelected', { bg = 'NONE', fg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineSeparatorVisible', { bg = 'NONE', fg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineDevIcon', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineDevIconSelected', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineDevIconVisible', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'BufferLineDevIcon', { fg = '#999999', bg = 'NONE' })
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    for _, group in ipairs(vim.fn.getcompletion('BufferLineDevIcon', 'highlight')) do
      vim.api.nvim_set_hl(0, group, { fg = 'NONE', bg = 'NONE' })
    end
  end,
})
require('bufferline').setup {
  highlights = {
    background = {
      fg = '#808080',
      bg = 'NONE',
    },
    buffer_selected = {
      fg = '#ffffff',
      bg = 'NONE',
      bold = true,
    },
    buffer_visible = {
      fg = '#a0a0a0',
      bg = 'NONE',
    },
  },
}
vim.cmd 'doautocmd ColorScheme'
vim.cmd [[
  highlight BufferLineBufferSelected guibg=NONE guifg=NONE gui=bold
]]



-- keymap for <Space>ff to open telescope
vim.api.nvim_set_keymap(
  'n', -- normal mode
  '<Space>ff', -- key combination
  "<cmd>lua require('telescope.builtin').find_files()<CR>", -- command to run
  { noremap = true, silent = true } -- options: non-recursive, silent
)


vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]


-- make blank-indent thinner
require("ibl").setup({
  indent = {
    char = "▏",  -- or "│", "▎", "¦", etc.
  }
})


-- neotree bindings
vim.keymap.set("n", "<C-t>", ":Neotree toggle<CR>", { desc = "Toggle NeoTree" })
--vim.api.nvim_create_autocmd("VimEnter", {
--  callback = function()
--    vim.defer_fn(function()
--      require("neo-tree.command").execute({ toggle = false, dir = vim.loop.cwd() })
--    end, 100) -- delay in ms
--  end,
--})
vim.api.nvim_create_autocmd({ "WinEnter", "WinLeave" }, {
  callback = function()
    vim.cmd([[
      highlight Normal guibg=NONE
      highlight NeoTreeNormal guibg=NONE
      highlight NeoTreeNormalNC guibg=NONE
      highlight NeoTreeWinSeparator guibg=NONE guifg=NONE
      highlight NeoTreeIndentMarker guibg=NONE
      highlight NeoTreeRootName guibg=NONE
    ]])
  end,
})
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "NONE", fg = "NONE" })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "NONE", fg = "NONE" })
    vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { bg = "NONE" })
  end,
})


