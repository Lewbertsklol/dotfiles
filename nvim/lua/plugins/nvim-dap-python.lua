if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  "mfussenegger/nvim-dap",
  dependencies = { "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap-python" },
  config = function()
    local dap = require "dap-python"

    dap.setup "python"

    table.insert(require("dap").configurations.python, {
      type = "python",
      request = "launch",
      python = "python",
      django = true,
      name = "Django",
      program = "manage.py",
      args = { "runserver", "--noreload" },
    })
  end,
}
