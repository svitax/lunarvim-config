-- Needed tailwind server to connect to markdown in order for all of this to work
lvim.lang.markdown.formatters = {
  {
    exe = "prettier",
  },
}
lvim.lang.markdown.linters = {
  -- {
  --   -- TODO install vale (copy from abzcoding/lvim)
  --   -- @usage can be write_good or vale or markdownlint
  --   -- exe = "vale",
  -- },
  {
    exe = "markdownlint",
  },
  {
    exe = "vale",
  },
  -- {
  --   exe = "write_good",
  -- },
}
