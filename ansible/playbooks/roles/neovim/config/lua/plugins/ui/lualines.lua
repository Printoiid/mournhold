return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local colors = {
			cyan = "#00FFFF",
			black = "#000000",
		}
		local hyper_theme = {
			normal = {
				a = { fg = colors.cyan, bg = colors.black, gui = "bold" },
				b = { fg = colors.cyan, bg = colors.black },
				c = { fg = colors.cyan, bg = colors.black },
			},
			insert = {
				a = { fg = colors.cyan, bg = colors.black },
				b = { fg = colors.cyan, bg = colors.black },
				c = { fg = colors.cyan, bg = colors.black },
			},
			visual = {
				a = { fg = colors.cyan, bg = colors.black },
			},
			replace = {
				a = { fg = colors.cyan, bg = colors.black },
			},
		}
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "" } } },
				lualine_b = { { "branch", separator = { left = "" } } },
				lualine_c = { { "filename", separator = { left = "" } } },
				lualine_x = { { "filetype", separator = { right = "" } } },
				lualine_y = { { "progress", separator = { right = "" } } },
				lualine_z = { { "location", separator = { right = "" } } },
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		})
	end,
}
