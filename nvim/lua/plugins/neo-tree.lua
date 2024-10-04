local collapse_folder = function(state)
  local node = state.tree:get_node()
  if node.type == "directory" and node:is_expanded() then
    require("neo-tree.sources.filesystem").toggle_directory(state, node)
  else
    require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
  end
end

local open_file = function(state)
  local node = state.tree:get_node()
  if node.type == "directory" then
    if not node:is_expanded() then
      require("neo-tree.sources.filesystem").toggle_directory(state, node)
    elseif node:has_children() then
      require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
    end
  else
    state.commands["open"](state)
    local bufs = vim.fn.getbufinfo { buflisted = 1 }
    for _, buf in pairs(bufs) do
      if buf.name == "" then require("astrocore.buffer").close_left() end
    end
  end
end

local function reload_lsp(opts)
  local event = opts.event
  return {
    event = event,
    handler = function(arg)
      local path = arg.destination or arg
      local python = string.sub(path, -3) == ".py"
      if python then vim.cmd "LspRestart basedpyright" end
    end,
  }
end

---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    event_handlers = {
      {
        event = "file_open_requested",
        handler = function(arg) require("neo-tree.command").execute { action = "close" } end,
      },
      reload_lsp { event = "file_added" },
      reload_lsp { event = "file_deleted" },
      reload_lsp { event = "file_renamed" },
    },
    source_selector = {
      sources = {
        { source = "filesystem" },
      },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        never_show = {
          ".git",
          ".obsidian",
        },
      },
    },
    window = {
      width = "20%",
      auto_expand_width = true,
      mappings = {
        ["h"] = collapse_folder,
        ["<left>"] = collapse_folder,
        ["l"] = open_file,
        ["<right>"] = open_file,
      },
    },
  },
}
