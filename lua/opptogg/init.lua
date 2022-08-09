local user_cmd = vim.api.nvim_create_user_command

user_cmd(
  'OppTogg',
  function ()
    require('opptogg.toggle').toggle()
  end,
  { nargs = 0 }
)

-- TODO: If user specifies command_center in config, enable a command center
-- call


