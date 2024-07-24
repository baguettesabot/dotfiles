return {
  { "folke/lazy.nvim" },

  --colors
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      vim.cmd [[ colorscheme gruvbox-material ]]
    end
  },
  { "Mofiqul/vscode.nvim" },
  { "olimorris/onedarkpro.nvim" },

  --file explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "fe", "<cmd>NvimTreeFocus<CR>", noremap = true },
      { "<Leader>fe", "<cmd>NvimTreeToggle<CR>", noremap = true }
    },
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      -- empty setup using defaults
      require("nvim-tree").setup()
    end
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },

  --fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
      }
    },
    keys = {
      { "fb", "<Cmd>Telescope file_browser<CR>", noremap = true },
      { "<leader>fb", "<Cmd>Telescope buffers<CR>", noremap = true },
      { "<leader>ff", "<Cmd>Telescope find_files<CR>", noremap = true },
      { "<leader>fg", "<Cmd>Telescope live_grep<CR>", noremap = true },
      { "<leader>fs", "<Cmd>Telescope grep_string<CR>", noremap = true },
    },
    config = function()
      local actions = require "telescope.actions"

      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist
            }
          },
        }
      })

      require("telescope").load_extension("fzf")
    end
  },
  --file browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    lazy = true,
    config = function()
      require("telescope").load_extension("file_browser")
    end
  },

  --better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require "nvim-treesitter.install".prefer_git = true
      require "nvim-treesitter".setup()
      require "nvim-treesitter.configs".setup {
        --always have c, lua, vim, vimdoc, query
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "java", "python", "cpp"},

        sync_install = false,

        auto_install = true,

        --parsers to ignore installing
        ignore_install = {},

        highlight = {
          enable = true,

          --parsers to disable
          disable = {}
        },

        indent = {
          enable = true
        }
      }
    end
  },
  --status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = ""},
          section_separators = { left = "", right = ""},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {"mode"},
          lualine_b = {"branch", "diff", "diagnostics"},
          lualine_c = {"filename"},
          lualine_x = {"encoding", "fileformat", "filetype"},
          lualine_y = {"progress"},
          lualine_z = {"location"}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {"filename"},
          lualine_x = {"location"},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end
  },

  --cosmetic for i/o
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy"
  },
  --autocomplete
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets"
    },
    config = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect"
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), --prev suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), --next suggest
          ["<C-b>"] = cmp.mapping.scroll_docs(-4), --backward forward preview window
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete, --show completion suggesitons
          ["<C-e>"] = cmp.mapping.abort(), --close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = false}),
        }),
        --sources for autocompletion
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, --snippets
          { name = "buffer" }, --text in current buffer
          { name = "path" }
        })
      })
    end
  },
  --lsp manager
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim"
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "pylsp",
        },
        automatic_installation = true
      })
    end
  },
  --lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
      local lspconfig = require "lspconfig"
      local cmp_nvim_lsp = require "cmp_nvim_lsp"

      local on_attach = require("config.keymappings").on_attach

      --enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      local signs = { Error = "󰰱 ", Warn = " ", Hint = "󰠠 ", Info = "󰋼 " }
      for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            --recognize "vim" global variable
            diagnostics = {
              globals = { "vim" }
            },
            workspace = {
              --make aware of runtime files
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true
              }
            }
          }
        }
      })

      lspconfig["clangd"].setup({
        capabilities = capabilities,
        on_attach = on_attach
      })

      lspconfig["pylsp"].setup({
        capabilities = capabilities,
        on_attach = on_attach
      })

    end
  },
  { "mfussenegger/nvim-jdtls" },

  -- autocomplete bracket, etc
  {
    "Raimondi/delimitMate",
  }
}
