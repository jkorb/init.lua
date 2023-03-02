-- Based on nvim-lua/kickstart.nvim

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
 
  use 'wbthomason/packer.nvim' -- Package manager

  use 'christoomey/vim-tmux-navigator'  -- Vim/tmux interaction

  use { -- Theme
    'navarasu/onedark.nvim',
    requires = { 'folke/lsp-colors.nvim' },
    config = function()
      require('onedark').setup {
        style = 'darker',
        transparent = true,
        term_colors = true,
        ending_tildes = true,
        cmp_itemkind_reverse = false,
        -- toggle theme style ---
        toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between
        code_style = {
          comments = 'italic',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none'
        },
        colors = {
		      alt_purple = "#bf68d9",
		      alt_green  = "#8ebd6b",
		      alt_orange = "#cc9057",
		      alt_blue   = "#4fa6ed",
		      alt_yellow = "#e2b86b",
		      alt_cyan   = "#48b0bd",
		      alt_red    = "#e55561",
		      alt_grey   = "#535965",
        }, -- Override default colors
        highlights = {
          ["@text.environment"]      = { fg = '$cyan' },
          ["@text.environment.name"] = { fg = '$yellow' },
          ["DiagnosticVirtualTextError"] = { fg = '$alt_red',    bg = 'c.none', fmt = 'bold' },
          ["DiagnosticVirtualTextWarn"]  = { fg = '$alt_yellow', bg = 'c.none', fmt = 'bold' },
          ["DiagnosticVirtualTextInfo"]  = { fg = '$alt_cyan',   bg = 'c.none', fmt = 'bold' },
          ["DiagnosticVirtualTextHint"]  = { fg = '$alt_purple', bg = 'c.none', fmt = 'bold' },
        },
        diagnostics = {
          darker = true, -- darker colors for diagnostic
          undercurl = true,   -- use undercurl instead of underline for diagnostics
          background = true,    -- use background color for virtual text
    },
      }
      require('onedark').load()
    end
  }

  use { -- Make things transparent
    'xiyaowong/nvim-transparent',
    config = function()
      require("transparent").setup({
        enable = true, -- boolean: enable transparent
      })
    end
  }

  use { -- Nice tab bar
    'romgrk/barbar.nvim',
    requires = 'nvim-tree/nvim-web-devicons'
  }

  use { -- Nice status line
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function()
      require('eviline')
    end,
    requires = 'nvim-tree/nvim-web-devicons',
  }

  use { -- Reopen files where I left them
    'farmergreg/vim-lastplace',
    setup = function()
      vim.g.lastplace_ignore = 'mail'
    end
  }

  use { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      -- See `:help indent_blankline.txt`
      require('indent_blankline').setup {
        -- char = '┊',
        show_trailing_blankline_indent = false,
      }
    end
  }

  use 'tpope/vim-sleuth'                    -- Detect tabstop and shiftwidth automatically

  use 'godlygeek/tabular'                   -- Tabularize!

  use {
    'ludovicchabant/vim-gutentags',
    config = function()
      vim.g.gutentags_cache_dir = vim.fn.stdpath('config') .. '/tags'
    end
  }

  use 'svermeulen/vim-cutlass' --Delete and don't yank

  use { -- Sort of kill-ring
    'svermeulen/vim-yoink',
    config = function()
      vim.g.yoinkIncludeDeleteOperations=1
    end
  }

  use {
    'lewis6991/spaceless.nvim',
    config = function()
      require'spaceless'.setup()
    end
  }

  use 'svermeulen/vim-subversive' -- Substitutions

  use 'tpope/vim-unimpaired'      -- Handy backet mappings, especially [<Space>

  use 'tpope/vim-commentary'      -- Quick comment functions, especially gc

  use 'tpope/vim-repeat'          -- Repeat actions with .

  use 'tpope/vim-surround'        -- Quickly edit surrounding brackets

  use 'tpope/vim-obsession'       -- Session management

  use 'tpope/vim-eunuch'          -- UNIX helpers: delete files

  use 'easymotion/vim-easymotion' -- Quickly move around

  use { 'L3MON4D3/LuaSnip',
    config = function ()
      require("luasnip").config.set_config({ -- Setting LuaSnip config
        -- Enable autotriggered snippets
        enable_autosnippets = true,
        -- Use Tab (or some other key if you prefer) to trigger visual selection
        store_selection_keys = "<Tab>",
        region_check_events = 'InsertEnter',
        delete_check_events = 'InsertLeave'
      })
      require("luasnip.loaders.from_vscode").lazy_load()
      -- require("luasnip.loaders.from_snipmate").lazy_load()
    end
  }

  use {
    "iurimateus/luasnip-latex-snippets.nvim",
    requires = { 'L3MON4D3/LuaSnip',
      'nvim-treesitter/nvim-treesitter',
      'rafamadriz/friendly-snippets'
    },
    config = function()
      require('luasnip-latex-snippets').setup({ use_treesitter = true })
    end,
    ft = "tex",
  }

  use {
    'folke/which-key.nvim',
    config = function()
      -- vim.o.timeoutlen = 300
      require("which-key").setup({})
    end,
  }

  use {
    'windwp/nvim-autopairs',
    config = function(_)
      require('nvim-autopairs').setup({
        check_ts                  = true,
        enable_afterquote         = true,
        enable_moveright          = true,
        enable_check_bracket_line = true,
      })
    end
    }

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    requires = { 'https://gitlab.com/HiPhish/nvim-ts-rainbow2' },
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help', 'vim', 'latex', 'bibtex', 'markdown', 'markdown_inline' },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        rainbow = {
          enable = true,
          disable = { "jsx", "cpp", "lua" },
          query = 'rainbow-parens',
          extended_mode = false,
          max_file_lines = nil,
        },
        indent = { enable = true, disable = { 'python' } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            node_incremental = '<TAB>',
            scope_incremental = '<CR>',
            node_decremental = '<S-TAB>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }

    end
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }

  use {
    'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim',
    config = function ()
      require('nvim-lightbulb').setup({autocmd = {enabled = true}})
    end
  }
 
  use 'junegunn/fzf.vim' --Vim fzf integration

  use {
    'gfanto/fzf-lsp.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    setup = function ()
      -- code
    end
  }

  use { 'tpope/vim-fugitive', -- Git
    requires = { 'lewis6991/gitsigns.nvim', 'tpope/vim-rhubarb' },
    config = function ()
      require('gitsigns').setup {
        on_attach = function(bufnr)

          -- local function map(mode, l, r, opts)
          --   opts = opts or {}
          --   opts.buffer = bufnr
          --   vim.keymap.set(mode, l, r, opts)
          -- end

          -- -- Navigation
          -- map('n', ']c', function()
          --   if vim.wo.diff then return ']c' end
          --   vim.schedule(function() gs.next_hunk() end)
          --   return '<Ignore>'
          -- end, {expr=true})

          -- map('n', '[c', function()
          --   if vim.wo.diff then return '[c' end
          --   vim.schedule(function() gs.prev_hunk() end)
          --   return '<Ignore>'
          -- end, {expr=true})

          -- Actions
          local wk = require("which-key")
          local gs = package.loaded.gitsigns

          wk.register({
            g = {
              s = { "<cmd>lua gs.stage_buffer()<CR>",       ": [s]tage buffer",                 opts },
              u = { "<cmd>lua gs.undo_stage_hunk()<CR>",    ": [u]ndo stage hunk",              opts },

              S = { "<cmd>Gitsigns stage_hunk<CR>",         ": [S]tage hunk",                   opts },
              R = { "<cmd>Gitsigns reset_hunk<CR>",         ": [R]tage hunk",                   opts },
            },
          }, { prefix = "<leader>" })

          -- map('n', '<leader>hR', gs.reset_buffer)
          -- map('n', '<leader>hp', gs.preview_hunk)
          -- map('n', '<leader>hb', function() gs.blame_line{full=true} end)
          -- map('n', '<leader>tb', gs.toggle_current_line_blame)
          -- map('n', '<leader>hd', gs.diffthis)
          -- map('n', '<leader>hD', function() gs.diffthis('~') end)
          -- map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

        end,
        signs = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
      }
    end
  }

  use 'jamessan/vim-gnupg'

  use {
    "folke/zen-mode.nvim",
    config = function()
      vim.api.nvim_set_hl(0, "ZenBg", { ctermbg = 0 })
      require("zen-mode").setup {
        window = {
          backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          -- height and width can be:
          -- * an absolute number of cells when > 1
          -- * a percentage of the width / height of the editor when <= 1
          -- * a function that returns the width or the height
          width = 120, -- width of the Zen window
          height = 1, -- height of the Zen window
          -- by default, no options are changed for the Zen window
          -- uncomment any of the options below, or add other vim.wo options you want to apply
          options = {
            -- signcolumn = "no", -- disable signcolumn
            -- number = false, -- disable number column
            -- relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        on_open = function ()
          vim.api.nvim_set_hl(0, "ZenBg", { ctermbg = 0 })
        end
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        dimming = {
          alpha = 0.75, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = { "Normal", "#ffffff" },
          term_bg = "#535965", -- if guibg=NONE, this will be used to calculate text color
          inactive = false,
        },
        context = 10, -- amount of lines we will try to show around the current line
        treesitter = true,
        expand = {
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {},
      }
    end
  }

  use { "barreiroleo/ltex-extra.nvim" }

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
    setup = function()
      Servers = {
        ltex    = {
          ltex = {
            enabled = { 'latex', 'tex', 'bib', 'markdown', 'text', 'mail' }, -- --   
            --   language = 'en',
            --   diagnosticSeverity = 'information',
            --   setenceCacheSize = 2000,
              additionalRules = {
            --     enablePickyRules = true,
                motherTongue = 'de-DE',
              },
            -- dictionary = { '', ''
            --   -- ['en-US'] = "~/.config/nvim/spell/ltex-ls.txt"
            -- },
            -- --   disabledRules = {},
            --   hiddenFalsePositives = {},
          }
        },
        yamlls = {},
        bashls = {},
        pyright = {},
        marksman = {},
        texlab = {
          texlab = {
            rootDirectory = nil,
            build = {
              executable = 'latexmk',
              args = { '-pdflatex', '-synctex=1', '%f' },
              onSave = false,
              forwardSearchAfter = false,
            },
            auxDirectory = '.',
            forwardSearch = {
              executable = 'zathura',
              args = {
                '--synctex-editor-command',
                [[nvim --headless -c "TexlabInverseSearch '%{input}' %{line}"]],
                '--synctex-forward',
                '%l:1:%f',
                '%p',
              }
            },
            chktex = {
              onOpenAndSave = true,
              onEdit = false,
            },
            diagnosticsDelay = 300,
            latexFormatter = 'latexindent',
            latexindent = {
              ['local'] = nil, -- local is a reserved keyword
              modifyLineBreaks = false,
            },
            bibtexFormatter = 'texlab',
            formatterLineLength = 80,
          }
        },
        sumneko_lua = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = {'vim'},
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
          },
        },
      }


    end,
    config = function()

      require('neodev').setup()
      require('mason').setup()
      vim.api.nvim_set_hl(0, "FidgetTask", { ctermbg = 0 })
      vim.api.nvim_set_hl(0, "FidgetTitle", { ctermbg = 0 })

      local on_attach = function(_, bufnr)
        local wk = require("which-key")
        local buf = vim.api.nvim_get_current_buf()
        local ft = vim.api.nvim_buf_get_option(buf, "filetype")
        local opts = { noremap = true, silent = true }

        if ft == 'markdown' or ft == 'tex' or ft == 'text' or ft == 'mail' then
          require("ltex_extra").setup({
            load_langs = { 'de-DE', 'en-US', 'nl-NL' },
            -- init_check = true, -- boolean : whether to load dictionaries on startup
            path = vim.fn.stdpath('config') .. '/spell',
          })
        end

        if ft == 'tex' then
          vim.api.nvim_buf_create_user_command(bufnr, 'TexlabClean', function(_)
            local arguments  = vim.lsp.util.make_text_document_params()
            vim.lsp.buf.execute_command({ command = "texlab.cleanAuxiliary", arguments = {arguments} })
          end, { desc = ' Texlab: Clean auxiliary files' })

          vim.api.nvim_buf_create_user_command(bufnr, 'TexlabPurge', function(_)
            local arguments  = vim.lsp.util.make_text_document_params()
            vim.lsp.buf.execute_command({ command = "texlab.cleanArtifacts", arguments = {arguments} })
          end, { desc = ' Texlab: Clean all files' })
          wk.register({
            l = {
              x = { "<cmd>TexlabClean<CR>",    " Texlab: [x] aux files",                 opts },
              X = { "<cmd>TexlabPurge<CR>",    " Texlab: [X] aux files",                 opts },
              c = { "<cmd>TexlabBuild<CR>",    " Texlab: [c]ompile",                   opts },
              v = { "<cmd>TexlabForward<CR>",  " Texlab: [v]iew",                      opts },
            },
          }, { prefix = "<leader>" })
        end

        vim.api.nvim_buf_create_user_command(bufnr, 'LSPFormat', function(_)
          vim.lsp.buf.format()
        end, { desc = ' LSP: Format current buffer' })

        vim.api.nvim_buf_create_user_command(bufnr, 'LSPPrintWS', function(_)
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { desc = ' LSP: Print list of workspace folders' })

        wk.register({
          w = {
            name = '[w]orkspace',
            a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",       " LSP: [a]dd folder",                 opts },
            r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",    " LSP: [r]remove folder",             opts },
            l = { "<cmd>LSPPrintWS<cr> ",                                  " LSP: [l]ist folders",               opts},
          },
          l = {
            -- f = { "<cmd>LSPFormat<cr>",              opts },
            f = { "<cmd>lua vim.lsp.buf.format()<cr>",                   " LSP: [f]ormat buffer",              opts },
            r = { "<cmd>lua vim.lsp.buf.rename()<cr>",                   " LSP: [r]ename buffer",              opts },
            a = { "<cmd>lua vim.lsp.buf.code_action()<cr>",              " LSP: code [a]ction",                opts },
          },
        }, { prefix = "<leader>" })

        wk.register({
          g = {
            d = { "<cmd>lua vim.lsp.buf.definition()<cr>",     " LSP: [d]efinition",      opts },
            I = { "<cmd>lua vim.lsp.buf.implementation()<cr>", " LSP: [i]mplementation",  opts },
            D = { "<cmd>lua vim.lsp.buf.declaration()<cr>",    " LSP: [D]eclaration",     opts },
          },
          K = { "<cmd>lua vim.lsp.buf.hover()<cr>",            " LSP: doc under [K]ey", opts },
        })

        -- nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
      end

      require('fidget').setup({
        text = {
          spinner = "dots_pulse",         -- animation shown when tasks are ongoing
          done = "",               -- character shown when all tasks are complete
          commenced = "Started",    -- message shown when task starts
          completed = "Completed",  -- message shown when task completes
        },
        timer = {
          spinner_rate = 250,       -- frame rate of spinner animation, in ms
          fidget_decay = 2000,      -- how long to keep around empty fidget, in ms
          task_decay = 1000,        -- how long to keep around completed task, in ms
        },
        window = {
          relative = "editor",         -- where to anchor, either "win" or "editor"
          blend = 0,              -- &winblend for the window
          zindex = nil,             -- the zindex value for the window
          border = "none",          -- style of border for the fidget window
        },
      })

      local mason_lspconfig = require('mason-lspconfig')

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(Servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)

          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

          if server_name == 'ltex' then
            require('lspconfig')['ltex'].setup ({
              filetypes = {
                "bib", "gitcommit", "markdown", "org", "plaintex", "rst",
                "rnoweb", "tex", "text", "mail"
              },
              capabilities = capabilities,
              on_attach = on_attach,
              settings = Servers[server_name],
            })
            vim.api.nvim_buf_create_user_command(0, 'LtexSwitchLang', function()

              local ltex_clients = vim.lsp.get_active_clients({bufnr=0, name="ltex"})

              for _, ltex_client in ipairs(ltex_clients) do
                vim.lsp.stop_client(ltex_client.id, false)
              end

              local lang = vim.fn.input('Language: ')

              local capabilities = vim.lsp.protocol.make_client_capabilities()
              capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

              require('lspconfig')['ltex'].setup({
                filetypes = {
                  "bib", "gitcommit", "markdown", "org", "plaintex", "rst",
                  "rnoweb", "tex", "text", "mail"
                },
                capabilities = capabilities,
                settings = {
                  ltex = {
                    enabled = { 'latex', 'tex', 'bib', 'markdown', 'text', 'mail' },
                    language = lang,
                    additionalRules = {
                      motherTongue = 'de-DE'
                    },
                  }
                }
              })

            end, { desc = ' Ltex: Switch language' })

            require('which-key').register({
              ls = {'<cmd>LtexSwitchLang<cr>', ' Ltex: Switch language'}
            }, { prefix = "<leader>" })
          else
            require('lspconfig')[server_name].setup ({
              capabilities = capabilities,
              on_attach = on_attach,
              settings = Servers[server_name],
            })
          end
        end,
      }
    end
  }

  use { 'vigoux/ltex-ls.nvim', requires = 'neovim/nvim-lspconfig' }

  use { '~/Dropbox/dots/minimal/config/nvim/my_plugins/cmp_email.nvim' }

  use { '~/Dropbox/dots/minimal/config/nvim/my_plugins/email.nvim' }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = {
      'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
      'kdheepak/cmp-latex-symbols', 'onsails/lspkind.nvim',
      'f3fora/cmp-spell', 'jc-doyle/cmp-pandoc-references'
    },
     
    config = function()
      -- nvim-cmp setup
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      local lspkind = require('lspkind')
      cmp.setup {
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
            preset = 'default',
            menu = ({
              buffer        = "[Buffer]",
              nvim_lsp      = "[ LSP]",
              luasnip       = "[LuaSnip]",
              cmdline       = "[Cmdline]",
              path          = "[Path]",
              latex_symbols = "[Latex]",
              cmp_email     = "[E-mail]",
              spell         = "[Spell]",
            }),
            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function (entry, vim_item)
              return vim_item
            end
          })
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
                    -- { name = 'omni' }
        },
      }

      cmp.setup.filetype({ 'markdown', 'pandoc'}, {
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'spell',
            option = {
              keep_all_entries = false,
              enable_in_context = function()
                return require('cmp.config.context').in_treesitter_capture('spell')
              end,
            },
          },
          { name = 'luasnip' },
          { name = 'pandoc_references'},
          { name = "latex_symbols",
            option = {
              strategy = 2,
            },
          },
        })
      })

      cmp.setup.filetype('mail', {
        sources = cmp.config.sources({
          { name = 'cmp_email' },
        }),
      })
      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
            { name = 'cmdline' }
          })
      })

    end
  }

end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

vim.o.termguicolors    = true
vim.o.hlsearch         = false -- Set highlight on search
vim.o.ignorecase       = true -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase        = true
vim.o.incsearch        = true
vim.o.updatetime       = 250 -- Decrease update time
vim.o.errorbells       = false
vim.o.showmode         = false
vim.o.scrolloff        = 10   -- Autoscroll when there's <= 10 lines left
vim.o.cursorline       = true -- Highlight current line
vim.o.breakindent      = true -- Enable break indent
vim.o.syntax           = 'off'
vim.o.expandtab        = true
vim.o.tabstop          = 2
vim.o.softtabstop      = 2
vim.o.shiftwidth       = 2
vim.bo.autoindent      = true
vim.bo.preserveindent  = true
vim.bo.smartindent     = true  -- Yes please
vim.wo.wrap            = true -- Don't wrap
vim.wo.signcolumn      = 'yes'
vim.wo.number          = true  -- Make line numbers default
vim.wo.relativenumber  = true  -- Relative line numbers
vim.o.hidden           = true
vim.o.undofile         = true -- Save undo history
vim.o.backup           = false
vim.o.undodir          = vim.fn.stdpath('config') .. '/undodir'
vim.o.directory        = vim.fn.stdpath('config') .. '/swapdir'
vim.bo.swapfile        = false --No swapfile
vim.o.sessionoptions   = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.o.completeopt      = 'menuone,noinsert,noselect' -- Set completeopt to have a better completion experience
vim.o.mouse            = 'a' -- Enable mouse mode
vim.o.clipboard        = 'unnamedplus'
vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '


local wk = require("which-key")
-- local opts = { noremap = true, silent = true }

wk.register({
  b = {
    name = '[b]uffer',
    d     = { '<cmd>bdelete<CR>',                     '[d]elete'},
    n     = { '<cmd>bnext<CR>',                       '[n]ext'},
    p     = { '<cmd>bprevious<CR>',                   '[p]revious'},
    ["<"] = { '<cmd>bprevious<CR>',                   '[p]revious'},
    [">"] = { '<cmd>bnext<CR>',                       '[n]ext'},
    ["1"] = { '<cmd>BufferGoto 1<CR>',                'change to: [1]'},
    ["2"] = { '<cmd>BufferGoto 2<CR>',                'change to: [2]'},
    ["3"] = { '<cmd>BufferGoto 3<CR>',                'change to: [3]'},
    ["4"] = { '<cmd>BufferGoto 4<CR>',                'change to: [4]'},
    ["5"] = { '<cmd>BufferGoto 5<CR>',                'change to: [5]'},
    ["6"] = { '<cmd>BufferGoto 6<CR>',                'change to: [6]'},
    ["7"] = { '<cmd>BufferGoto 7<CR>',                'change to: [7]'},
    ["8"] = { '<cmd>BufferGoto 8<CR>',                'change to: [8]'},
    ["9"] = { '<cmd>BufferGoto 9<CR>',                'change to: [9]'},
    ["0"] = { '<cmd>BufferLast<CR>',                  'change to: [0]'},
  },
  c = {
    name = '[c]hange',
    h = { '<cmd>noh<CR>',  '[h]ightlighting'}
  },
  d = {
    name = '[d]iagnostics',
    p = { '<cmd>lua vim.diagnostic.goto_prev()<CR>',    '[p]revious'},
    n = { '<cmd>lua vim.diagnostic.goto_next()<CR>',    '[n]ext'},
    o = { '<cmd>lua vim.diagnostic.open_float()<CR>',   '[o]pen float'},
    h = { '<cmd>lua vim.diagnostic.hide()<CR>',         '[h]ide'},
    t = { '<cmd>TroubleToggle<CR>',                     '[t]oggle trouble.nvim'},
    T = { '<cmd>TroubleToggle document_diagnostics<CR>','[T]oggle trouble.nvim'},
  },
  f = {
    name = '[f]zf',
    g = { '<cmd>GFiles<CR>',                          '[g]it files'},
    l = { '<cmd>Lines<CR>',                           '[l]ines'},
    t = { '<cmd>Tags<CR>',                            '[t]ags'},
    m = { '<cmd>Marks<CR>',                           '[m]arks'},
    w = { '<cmd>Windows<CR>',                         '[w]indows'},
    h = { '<cmd>History<CR>',                         '[h]istory'},
    s = { '<cmd>Snippets<CR>',                        '[s]nippets'},
    c = { '<cmd>Commands<CR>',                        '[c]ommands'},
  },
  g = {
    name = '[g]it',
  },
  l = {
    name = '[l]sp',
  },
  s = {
    name = '[s]pell',
    t = { '<cmd>setlocal spell!<CR>',                 '[t]oggle'},
    d = { '<cmd>setlocal spelllang=nl<CR>',           '[d]utch'},
    g = { '<cmd>setlocal spelllang=de<CR>',           '[g]erman'},
    e = { '<cmd>setlocal spelllang=en_us<CR>',        '[e]nglish'},
    n = { ']s',                                       '[n]ext'},
    p = { '[s',                                       '[p]revious'},
    N = { ']S',                                       '[N]ext'},
    P = { '[S',                                       '[P]ext'},
    a = { 'zG',                                       '[a]ccept (temporarily)'},
    A = { 'zg',                                       '[A]ccept (permanently)'},
    w = { 'zW',                                       '[w]rong (temporarily)'},
    W = { 'zw',                                       '[W]rong (permanently)'},
    c = { 'z=',                                       '[c]orrect'},
    r = { '<cmd>spellr<CR>',                          '[r]epat correction'},
    q = { '[s1z=`]a',                                 '[q]uick fix'},
  },
  ["."] = {'<cmd>Files<CR>',                          'fzf files' },
  [","] = {'<cmd>Buffers<CR>',                        'fzf buffers' },
}, { prefix = "<leader>" })


wk.register({
  g = {
    name = '[g]oto',
    a = { '<cmd>lua vim.lsp.buf.code_action()<cr>' , ' LSP: code [a]ction' },
    t = { ':BufferPrevious<CR>'                    , 'prev [T]ab'           },
    T = { ':BufferNext<CR>'                        , 'next [t]ab'           },
    p = { '<plug>(YoinkPaste_gp)'                  , '[p]aste after'        },
    P = { '<plug>(YoinkPaste_gP)'                  , '[P]aste before'       },
  },
  p = { '<plug>(YoinkPaste_p)', '[p]aste after' },
  P = { '<plug>(YoinkPaste_P)', '[P]aste before'},
  y = { '<plug>(YoinkYankPreserveCursorPosition)', '[y]ank' },
  ["<C-n>"] = {'<plug>(YoinkPostPasteSwapBack)', '[n]ext yoink'},
  ["<C-p>"] = {'<plug>(YoinkPostPasteSwapForward)', '[n]ext yoink'},
  x  = { 'd',  'delete with x'},
  xx = { 'dd', 'delete with x'},
  X  = { 'D',  'delete with x'},
}, { mode = 'n' })

wk.register({
  x  = { 'd',  'delete with x'},
  y  = { '<plug>(YoinkYankPreserveCursorPosition)', '[y]ank' },
}, { mode = 'x' })

-- [ Highlight on yank ]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.diagnostic.config({
  virtual_text = {
    -- source = "always",  -- Or "if_many"
    prefix = '', -- Could be '■', '▎', 'x'
    format = function(diagnostic)
      if diagnostic.severity == vim.diagnostic.severity.ERROR then
        return string.format("● %s", diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.WARN then
        return string.format("● %s", diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.INFO then
        return string.format("●  %s", diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.HINT then
        return string.format("●  %s", diagnostic.message)
      end
      return diagnostic.message
    end
  },
  severity_sort = true,
  -- float = {
  --   source = "always",  -- Or "if_many"
  -- },
})


local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
