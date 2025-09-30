local function get_gtest_under_cursor()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor()
  local bufnr = vim.api.nvim_get_current_buf()
  if not node then return nil end
  while node do
    if node:type() == "function_definition" then
      local declarator = node:child(0)
      if declarator and declarator:type() == "function_declarator" then
        local identifier = declarator:child(0)
        if identifier and identifier:type() == "identifier" then
          local name = vim.treesitter.get_node_text(identifier, bufnr)
          if name == "TEST" or name == "TEST_F" or name == "TEST_P" then
            local parameters = declarator:child(1)
            if parameters and parameters:type() == "parameter_list" then
              local text = vim.treesitter.get_node_text(parameters, bufnr)
              local suite, test = text:match("([%w_]+)%s*,%s*([%w_]+)")
              if suite and test then return suite .. "." .. test end
            end
          end
        end
      end
    end
    node = node:parent()
  end
  return nil
end

-- TODO: Detect if filter didn't match any tests.
vim.api.nvim_create_user_command("GTestRun", function(opts)
  local old_dir = vim.fn.getcwd()
  local temp_dir = opts.fargs[2]
  local has_temp_dir = temp_dir ~= nil and temp_dir ~= ""
  if has_temp_dir then vim.cmd("cd " .. temp_dir) end

  if vim.g.gtest_executable == nil then
    print("gtest_executable not set for this buffer")
    if has_temp_dir then vim.cmd("cd " .. old_dir) end
    return
  end
  local cmd = vim.g.gtest_executable .. " --gtest_filter=" .. opts.fargs[1]
  vim.fn.setqflist({}, "r", { title = "GTest", lines = {}, efm = "%f:%l:%c: %m" })
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then vim.fn.setqflist({}, "a", { lines = data }) end
    end,
    on_stderr = function(_, data)
      if data then vim.fn.setqflist({}, "a", { lines = data }) end
    end,
    on_exit = function(_, code)
      if code ~= 0 and code ~= 1 then
        print(vim.g.gtest_executable .. " failed with exit code: " .. code)
        if has_temp_dir then vim.cmd("cd " .. old_dir) end
        return
      end
      if code == 0 then
        print(opts.fargs[1] .. " passed")
        if has_temp_dir then vim.cmd("cd " .. old_dir) end
        return
      end
      vim.cmd("copen")
      if has_temp_dir then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = "*",
          callback = function() vim.cmd("cd " .. old_dir) end,
          once = true,
        })
      end
    end,
  })
end, {
  nargs = "+",
})

vim.keymap.set("n", "<leader>tf", ":GTestRun ", { desc = "[T]est with [F]ilter" })

vim.keymap.set(
  "n",
  "<leader>tt",
  function() vim.cmd("GTestRun " .. get_gtest_under_cursor()) end,
  { desc = "[T]est under cursor" }
)
