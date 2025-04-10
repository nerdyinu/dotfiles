return {
  "mrcjkb/rustaceanvim",
  opts = {
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = "all",
          },
          check = {
            command = "clippy",
            extraArgs = { "--all-features", "--tests", "--", "-W", "clippy::pedantic" },
          },
          rustfmt = {
            extraArgs = { "--config", "group_imports=StdExternalCrate" },
          },
          inlayHints = {
            chainingHints = { enable = true },
            parameterHints = { enable = true },
            typeHints = { enable = true },
            renderColons = true,
            closingBraceHints = {
              enable = true,
              minLines = 25,
            },
          },
        },
      },
      hint = { enabled = true },
    },
  },
}
