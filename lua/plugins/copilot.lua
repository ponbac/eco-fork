require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<M-l>",
      accept_word = "<M-k>",
    },
  },
  panel = { enabled = false },
})
