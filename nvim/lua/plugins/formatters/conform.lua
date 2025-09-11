return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			html = { "prettier" },
		},
		format_on_save = {
			lsp_format = "if_nil_then_conform",
			async = false,
		},
	},
}
