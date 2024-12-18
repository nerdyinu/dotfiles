return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<C-n>"] = {},
      ["<C-p>"] = {},
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
    },
  },
}
