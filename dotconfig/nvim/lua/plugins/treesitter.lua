return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter").setup()
		require("nvim-treesitter.configs").setup {
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "java", "python", "cpp"},

			sync_install = false,
			auto_install = true,
			ignore_install = {},

			highlight = {
				enable = true,
				disable = {}
			},

			indent = {
				enable = true
			}
		}
	end
}
