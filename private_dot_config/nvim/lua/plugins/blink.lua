return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<C-n>"] = {},
      ["<C-p>"] = {},
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },
  },
}
