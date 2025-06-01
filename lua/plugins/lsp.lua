return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      -- 1. Mason setup
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "lua_ls" },
        automatic_installation = true,
      })

      -- 2. LSP servers setup
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- General on_attach function for keymaps (optional)
      local on_attach = function(client, bufnr)
        -- Your keymaps here
      end

      local servers = { "clangd", "lua_ls" }
      for _, server in ipairs(servers) do
        local opts = {
          capabilities = capabilities,
          on_attach = on_attach,
        }

        if server == "lua_ls" then
          opts.settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          }
        end

        lspconfig[server].setup(opts)
      end

      -- 3. Completion setup
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      })
    end,
  }
}
