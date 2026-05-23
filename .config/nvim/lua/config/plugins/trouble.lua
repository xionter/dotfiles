return {
	"folke/trouble.nvim",
	opts = {},
	keys = {
		{
			"<leader>tt", "<cmd>Trouble diagnostics toggle<cr>",
		},
		{
			"]t",
			function()
				require("trouble").next({skip_groups = true, jump = true,})
			end,
		},
		{
			"[t",
			function()
				require("trouble").prev({skip_groups = true, jump = true,})
			end,
		},
	},
}
