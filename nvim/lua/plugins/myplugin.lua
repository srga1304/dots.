return {
  "neographnotes.nvim",
  dir = vim.fn.expand("~/dev/nvimPlug/NeoGraphNotes"),
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "NeoGraphNotes",
  config = function()
    require("neographnotes").setup({
      python_path = vim.fn.expand("~/nvimPlug/NeoGraphNotes/venv/bin/python"),
      notes_path = vim.fn.expand("~/orgfiles")
    })
  end,
}