return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local colors = {
			cyan = "#00FFFF",
		}

		local hyper_theme = {
			normal = {
				a = { fg = colors.cyan, bg = colors.cyan },
				b = { fg = colors.cyan, bg = colors.cyan },
				c = { fg = colors.cyan },
			},
			insert = { a = { fg = colors.cyan, bg = colors.cyan } },
			visual = { a = { fg = colors.cyan, bg = colors.cyan } },
			replace = { a = { fg = colors.cyan, bg = colors.cyan } },
		}

		require("lualine").setup({
			options = {
				theme = "hyper_theme",
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 3 } },
				lualine_b = { "filename", "branch" },
				lualine_c = {
					"%=", --[[ add your center compoentnts here in place of this comment ]]
				},
				lualine_x = {},
				lualine_y = { "filetype", "progress" },
				lualine_z = {
					{ "location", separator = { right = "" }, left_padding = 2 },
				},
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
