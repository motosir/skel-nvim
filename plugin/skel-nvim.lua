
vim.api.nvim_create_user_command(
  "SkelEnable",
  function(opts)
    require"skel-nvim".enable()
  end,
  {}
)

vim.api.nvim_create_user_command(
  "SkelDisable",
  function(opts)
    require"skel-nvim".disable()
  end,
  {}
)

vim.api.nvim_create_user_command(
  "SkelStatus",
  function(opts)
    require"skel-nvim".status()
  end,
  {}
)

vim.api.nvim_create_user_command(
  "SkelRun",
  function(opts)
    require"skel-nvim".run_on_current_buffer()
  end,
  {}
)

vim.api.nvim_create_user_command(
  "SkelEdit",
  function(opts)
    require"skel-nvim".create_file(opts)
  end,
  {nargs=1}
)

