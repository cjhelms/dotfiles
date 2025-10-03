local M = {}

function M.push_to_gerrit()
  require("fzf-lua").git_branches({
    prompt = "Select branch> ",
    actions = {
      ["default"] = function(selected)
        local branch = selected[1]:gsub("^[%*%s*]+", "")
        if not branch then return end
        local ready_for_review = "1. Ready for review"
        local work_in_progress = "2. Work-in-progress"
        local private = "3. Private"
        require("fzf-lua").fzf_exec({ ready_for_review, work_in_progress, private }, {
          prompt = "Push Type> ",
          actions = {
            ["default"] = function(selection)
              local specifier = ""
              if selection[1] == work_in_progress then
                specifier = "%wip"
              elseif selection[1] == private then
                specifier = "%private"
              end
              local bufnr = vim.api.nvim_create_buf(true, false)
              vim.api.nvim_open_win(bufnr, true, { split = "below", height = 10 })
              vim.fn.termopen({ "git", "push", "origin", "HEAD:refs/for/" .. branch .. specifier })
            end,
          },
        })
      end,
    },
  })
end

return M
