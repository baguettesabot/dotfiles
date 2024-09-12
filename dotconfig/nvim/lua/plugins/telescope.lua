return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ 
				"nvim-telescope/telescope-file-browser.nvim",
				dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
			}
		},
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>" },
			{ "fb", "<cmd>Telescope buffers<cr>" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>" },
			{ "<leader>fb", "<cmd>Telescope file_browser<cr>" },
		},
		config = function()
			actions = require("telescope.actions")

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist
						}
					},
				}
			})
		end
	}
}
