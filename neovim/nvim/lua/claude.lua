require("claude-code").setup({
	-- 终端窗口设置
	window = {
		split_ratio = 0.3,      -- 终端窗口占屏幕的百分比
		position = "botright",  -- 窗口位置："botright", "topleft", "vertical", "float"等
		enter_insert = true,    -- 打开Claude Code时是否进入插入模式
		hide_numbers = true,    -- 隐藏终端窗口的行号
		hide_signcolumn = true, -- 隐藏终端窗口的符号列

		-- 浮动窗口配置（仅当position = "float"时适用）
		float = {
			width = "80%",        -- 宽度：列数或百分比字符串
			height = "80%",       -- 高度：行数或百分比字符串
			row = "center",       -- 行位置：数字、"center"或百分比字符串
			col = "center",       -- 列位置：数字、"center"或百分比字符串
			relative = "editor",  -- 相对位置："editor"或"cursor"
			border = "rounded",   -- 边框样式："none", "single", "double", "rounded"等
		},
	},
	-- 文件刷新设置
	refresh = {
		enable = true,           -- 启用文件变化检测
		updatetime = 100,        -- Claude Code活动时的更新时间（毫秒）
		timer_interval = 1000,   -- 检查文件变化的频率（毫秒）
		show_notifications = true, -- 文件重新加载时显示通知
	},
})
