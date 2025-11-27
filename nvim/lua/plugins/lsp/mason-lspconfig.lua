return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		-- NOTE: You can *only* `ensure_installed` for LSPs, literally nothing else.
		-- NOTE: SuperHTML is an LSP _and_ a formatter.
		ensure_installed = { "lua_ls", "gopls", "templ", "jsonls", "yamlls", "powershell_es" },
	},
	dependencies = {
		{
			"WhoIsSethDaniel/mason-tool-installer",
			opts = {
				-- NOTE: This is where you can ensure the installation of DAPs, Linters, and Formatters.
				-- This should be able to work with mason-lspconfig, but for whatever reason it's not supported.
				ensure_installed = { "superhtml", "stylua" },
			},
		},
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					backdrop = 20,
					width = 0.9,
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
		},
	},
}
