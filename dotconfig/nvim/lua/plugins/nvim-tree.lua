return {
	"nvim-tree/nvim-tree.lua",
  lazy = true,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<Leader>fe", "<cmd>NvimTreeToggle<CR>" },
	},
	config = function()
		require("nvim-tree").setup()
	end
}
