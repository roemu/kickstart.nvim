-- return {
--   "nvim-neo-tree/neo-tree.nvim",
--   branch = "v3.x",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-tree/nvim-web-devicons",
--     "MunifTanjim/nui.nvim",
--   },
--   opts = {
--     filesystem = {
--       filtered_items = {
--         visible = true
--       }
--     },
--   },
--   keys = function()
--     return {
--       { "<leader>nt", "<cmd>Neotree toggle=true<cr>", desc = "Toggle Neotree" },
--     }
--   end,
--   config = function ()
--      
--   end
-- }
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      update_focused_file = { enable = true },
      actions = {
        open_file = {
          quit_on_open = true
        }
      }
    }
  end,
  keys = function()
    return {
      { "<leader>nt", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Neotree" },
    }
  end,
}
