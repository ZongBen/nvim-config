local function cmd(mode, command)
	vim.api.nvim_create_autocmd(mode, {
		pattern = "*",
		callback = function()
			vim.cmd(command)
		end,
	})
end

cmd("InsertLeave", "CapsLockOff")
