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
			{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>" },
			{ "fb", "<cmd>Telescope file_browser<cr>" }
		},
		config = function()
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
		end
	}
}
