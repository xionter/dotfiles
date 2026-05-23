return {
	'nvim-telescope/telescope.nvim',
	version = '*',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},

	config = function()
		require('telescope').setup({
			defaults = {
				layout_config = {
					height = 0.95,
					preview_cutoff = 1,
					vertical = {
						width = 0.9,
						height = 0.95,
						preview_height = 0.6,
					},
				},
			},

			pickers = {
				find_files = {
					theme = "ivy",
					previewer = true,
				}
			},
		})

		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>pf', builtin.find_files)
		vim.keymap.set('n', '<C-p>', builtin.git_files, {})
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({
				search = vim.fn.input("Grep > ")
			})
		end)
		vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
		vim.keymap.set('n', '<leader>pws', function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		require('config.telescope.multigrep').setup()
	end,
}
