
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      ensure_installed = { "bash", "css", "html", "javascript", "lua", "rust", "c_sharp" },
      auto_install = true,
    })
  end,
}
