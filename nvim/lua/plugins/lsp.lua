
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local on_attach = function(_, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason").setup({
      ensure_installed = {
        "cssls",
        "html",
        "typescript-language-server",
        "rust-analyzer",
        "omnisharp"
      }
    })

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
        ["omnisharp"] = function()
          require("lspconfig").omnisharp.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              cmd = { "omnisharp" },
          })
        end
      }
    })
  end,
}
