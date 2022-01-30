local notify = require("notify")
local t = os.date ("*t") --> produces a table like this:
local time_left = 30 - t.min % 30
local function min(m)
  return m * 60 * 1000
end

-- 同样的处理掉这个 bug
local function drink_water()
		local timer = vim.loop.new_timer()
		timer:start(0, min(30), function()
			notify({"Drink Water", "🦁" }, "info", {
				title = "Drink water",
				timeout = min(1),
			})
		end)
end

drink_water()
