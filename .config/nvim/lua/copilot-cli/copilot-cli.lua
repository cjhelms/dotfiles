local M = {}

-- Store the terminal buffer and job ID globally
local copilot_term = {
  bufnr = nil,
  winnr = nil,
  job_id = nil,
}

-- Function to open or focus Copilot terminal
function M.CopilotTerminal()
  -- Check if terminal buffer still exists and is valid
  if copilot_term.bufnr and vim.api.nvim_buf_is_valid(copilot_term.bufnr) then
    -- Check if window is already open
    local wins = vim.fn.win_findbuf(copilot_term.bufnr)
    if #wins > 0 then
      -- Terminal is visible, just focus it
      vim.api.nvim_set_current_win(wins[1])
    else
      -- Terminal exists but not visible, show it
      vim.cmd("botright split")
      vim.api.nvim_win_set_buf(0, copilot_term.bufnr)
      vim.cmd("resize 15") -- Set height
      copilot_term.winnr = vim.api.nvim_get_current_win()
    end
  else
    -- Create new terminal with Copilot
    vim.cmd("botright split")
    vim.cmd("resize 15")
    copilot_term.bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(0, copilot_term.bufnr)
    copilot_term.winnr = vim.api.nvim_get_current_win()

    -- Start Copilot CLI
    copilot_term.job_id = vim.fn.termopen("copilot", {
      on_exit = function()
        copilot_term.bufnr = nil
        copilot_term.winnr = nil
        copilot_term.job_id = nil
      end,
    })

    -- Enter terminal insert mode
    vim.cmd("startinsert")
  end
end

-- Function to send text to Copilot terminal
function M.CopilotSend(text)
  if copilot_term.job_id then vim.fn.chansend(copilot_term.job_id, text .. "\n") end
end

return M
