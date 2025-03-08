require('config.lazy')
require('mason').setup()

require('mason-lspconfig').setup{
  ensure_installed = {'lua_ls', 'rust_analyzer'}
}

local lspconf = require('lspconfig')

vim.opt.number = true;
vim.opt.relativenumber = true;
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

lspconf.lua_ls.setup {
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
	end,
	settings = {
		Lua = {}
	} }

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
