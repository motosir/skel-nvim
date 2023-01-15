local M = {}

-- Can't use telescope as the picker due to a bug when running telescope during startup
-- see: https://github.com/nvim-telescope/telescope.nvim/issues/1743
--
-- local actions = require "telescope"
-- local actions = require "telescope.actions"
-- local action_state = require "telescope.actions.state"
-- local pickers = require "telescope.pickers"
-- local finders = require "telescope.finders"
-- local sorters = require "telescope.sorters"
-- local dropdown = require "telescope.themes".get_dropdown()

-- function M.get_selection2(array, callback)

--   -- handle <CR> key press in telescope
--   local function enter(prompt_bufnr)
--     local selected = action_state.get_selected_entry()
--     actions.close(prompt_bufnr)
--     callback(selected[1])
--   end

--   local mini = {
--     layout_strategy = "vertical",
--     layout_config = {
--       height = 10,
--       width  = 0.3,
--     },
--   }

--   local opts = {
--     finder = finders.new_table(array),
--     sorter = sorters.get_generic_fuzzy_sorter({}),

--     attach_mappings = function(prompt_bufnr, map)
--       map("i", "<CR>", enter)
--       map("n", "<CR>", enter)
--       return true
--     end,
--   }

--   -- local colors = pickers.new(dropdown, opts)
--   local colors = pickers.new(mini, opts)

--   colors:find()

-- end


function M.get_selection(array, callback)
  vim.ui.select(array,
    {prompt='skel: select template'},
    function(choice)
      if choice ~= nil then
        callback(choice)
      end
    end
  )
end

return M
