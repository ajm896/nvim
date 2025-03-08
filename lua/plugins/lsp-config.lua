return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconf = require('lspconfig')
    lspconf.lua_ls.setup {
      -- Begin on_init
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath('config') and
              (vim.loop.fs_stat(path .. '/.luarc.json') or
                vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          },
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = 2,
            }
          }
        })
        -- End on_init
      end,

      settings = {
        Lua = {}
      }
      -- End setup
    }
  end
}
