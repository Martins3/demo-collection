local function hi()
  print("this is a function")
end

-- 似乎存在一些更好的
-- 主要的参考资料
-- 似乎，使用 nvim-notify 作为阅读卡片是更加好用的呀
-- https://github.com/rcarriga/nvim-notify
-- https://github.com/jacobsimpson/nvim-example-lua-plugin
-- https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup

local Popup = require("nui.popup")

local popup = Popup({
  position = "50%",
  size = {
    width = 40,
    height = 40,
  },
  enter = true,
  focusable = true,
  zindex = 50,
  relative = "editor",
  border = {
    highlight = "FloatBorder",
    padding = {
      top = 2,
      bottom = 2,
      left = 3,
      right = 3,
    },
    style = "rounded",
    text = {
      top = "r(remember) f(forget) q(exit)",
      top_align = "center",
    },
  },
  buf_options = {
    modifiable = false,
    readonly = true,
  },
  win_options = {
    winblend = 10,
    winhighlight = "Normal:Normal",
  },
})

local function exit()
  print("ESC pressed in Normal mode!")
  popup:unmount()
end

FilePath="/home/maritns3/.SpaceVim.d/checksheet"

GlobalCounter=1

-- 设计上，就是使用 # 就可以了
local function edit()
  popup:unmount()
  vim.api.nvim_command('edit ' .. FilePath)
end

local function remember()
  print("you remember it")
end

local function forget()
  print("you forget it")
end

function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "'..directory..'"')
    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end

local function read_file_into_qa(filename)
  local f = io.open(filename, "wr");
end

local function local_lua_function()
  local file = io.open(FilePath, "r");
  -- local foo = file:read("*a")

  local arr = {}
  for line in file:lines() do
      table.insert(arr, line);
  end

  table.insert(arr, tostring(GlobalCounter))
  GlobalCounter = GlobalCounter + 1

  -- print(vim.inspect(vim.api))
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, arr)
  popup.bufnr = bufnr
  vim.api.nvim_buf_set_option(bufnr, "filetype","markdown")

  popup:mount()
  popup:map("n", "q", exit, { noremap = true })
  popup:map("n", "e", edit, { noremap = true })
  popup:map("n", "r", remember, { noremap = true })
  popup:map("n", "f", forget, { noremap = true })
end

return {
    local_lua_function = local_lua_function,
    hi = hi
}
