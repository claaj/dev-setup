-- Funciones para detectar automaticamente que debuggear
local function get_cpp_executable()
	local current_dir = vim.fn.getcwd()

	local cmake_build = current_dir .. "/build/compile_commands.json"
	local make_exec = current_dir .. "/Makefile"

	if vim.fn.filereadable(cmake_build) == 1 then
		local build_dir = current_dir .. "/build/"
		local files = vim.fn.glob(build_dir .. "*", 0, 1)
		local executables = {}

		for _, file in ipairs(files) do
			if vim.fn.executable(file) == 1 then
				table.insert(executables, file)
			end
		end

		if #executables == 1 then
			return executables[1]
		elseif #executables > 1 then
			print("Multiple executables found:")
			for i, exec in ipairs(executables) do
				print(i .. ": " .. vim.fn.fnamemodify(exec, ":t"))
			end
			local choice = tonumber(vim.fn.input("Select executable (1-" .. #executables .. "): "))
			if choice and choice >= 1 and choice <= #executables then
				return executables[choice]
			end
		end
	elseif vim.fn.filereadable(make_exec) == 1 then
		local files = vim.fn.glob(current_dir .. "/*", 0, 1)
		local executables = {}

		for _, file in ipairs(files) do
			if vim.fn.executable(file) == 1 then
				table.insert(executables, file)
			end
		end

		if #executables == 1 then
			return executables[1]
		elseif #executables > 1 then
			print("Multiple executables found:")
			for i, exec in ipairs(executables) do
				print(i .. ": " .. vim.fn.fnamemodify(exec, ":t"))
			end
			local choice = tonumber(vim.fn.input("Select executable (1-" .. #executables .. "): "))
			if choice and choice >= 1 and choice <= #executables then
				return executables[choice]
			end
		end
	else
		local source_name = vim.fn.expand("%:t:r")
		local possible_exec = current_dir .. "/" .. source_name

		if vim.fn.executable(possible_exec) == 1 then
			return possible_exec
		end
	end

	return vim.fn.input("Path to executable: ", current_dir .. "/", "file")
end

local function get_rust_executable()
	local cargo_toml = vim.fn.getcwd() .. "/Cargo.toml"
	local default_target = vim.fn.getcwd() .. "/target/debug/"

	if vim.fn.filereadable(cargo_toml) ~= 1 then
		print("No Cargo.toml found")
		return vim.fn.input("Path to executable: ", default_target, "file")
	end

	local lines = vim.fn.readfile(cargo_toml)
	local project_name = nil
	local bin_targets = {}
	local in_bin_section = false

	for _, line in ipairs(lines) do
		local name = line:match('^name%s*=%s*"([^"]+)"')
		if name then
			project_name = name
		end

		if line:match("%[%[bin%]%]") then
			in_bin_section = true
		elseif in_bin_section and line:match('^name%s*=%s*"([^"]+)"') then
			local bin_name = line:match('^name%s*=%s*"([^"]+)"')
			table.insert(bin_targets, bin_name)
		elseif line:match("%[") then
			in_bin_section = false
		end
	end

	if #bin_targets == 0 and project_name then
		local executable = default_target .. project_name
		if vim.fn.executable(executable) == 1 then
			return executable
		end
	elseif #bin_targets == 1 then
		local executable = default_target .. bin_targets[1]
		if vim.fn.executable(executable) == 1 then
			return executable
		end
	elseif #bin_targets > 1 then
		print("Multiple binaries found:")
		for i, name in ipairs(bin_targets) do
			print(i .. ": " .. name)
		end
		local choice = tonumber(vim.fn.input("Select binary (1-" .. #bin_targets .. "): "))
		if choice and choice >= 1 and choice <= #bin_targets then
			local executable = default_target .. bin_targets[choice]
			if vim.fn.executable(executable) == 1 then
				return executable
			end
		end
	end

	print("No executable found in target/debug/")
	return vim.fn.input("Path to executable: ", default_target, "file")
end

local function detect_project_type()
	local current_dir = vim.fn.getcwd()

	if vim.fn.filereadable(current_dir .. "/Cargo.toml") == 1 then
		return "rust"
	elseif vim.fn.filereadable(current_dir .. "/CMakeLists.txt") == 1 then
		return "cmake"
	elseif vim.fn.filereadable(current_dir .. "/Makefile") == 1 then
		return "make"
	end

	-- Detectar por el tipo de archivo actual
	local current_file = vim.fn.expand("%:e")
	if current_file == "rs" then
		return "rust"
	elseif current_file == "cpp" or current_file == "cc" or current_file == "cxx" then
		return "cpp"
	elseif current_file == "c" then
		return "c"
	end

	return "unknown"
end

local function get_executable()
	local project_type = detect_project_type()

	if project_type == "rust" then
		return get_rust_executable()
	else
		return get_cpp_executable()
	end
end

return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local mason_registry = require("mason-registry")

			if not mason_registry.is_installed("cpptools") then
				vim.cmd("MasonInstall cpptools")
			end

			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = mason_registry.get_package("cpptools"):get_install_path()
					.. "/extension/debugAdapters/bin/OpenDebugAD7",
			}

			local debug_configurations = {
				{
					name = "Debug C/C++/Rust (Launch)",
					type = "cppdbg",
					request = "launch",
					program = get_executable,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
					MIMode = "gdb",
					miDebuggerPath = "/usr/bin/gdb",
					setupCommands = {
						{
							description = "Enable pretty-printing",
							text = "-enable-pretty-printing",
							ignoreFailures = false,
						},
						{
							description = "Set Disassembly Flavor to Intel",
							text = "-gdb-set disassembly-flavor intel",
							ignoreFailures = false,
						},
					},
				},
				{
					name = "Debug C/C++/Rust (GDB Server)",
					type = "cppdbg",
					request = "launch",
					program = get_executable,
					cwd = "${workspaceFolder}",
					MIMode = "gdb",
					miDebuggerServerAddress = "localhost:1234",
					miDebuggerPath = "/usr/bin/gdb",
					setupCommands = {
						{
							description = "Enable pretty-printing",
							text = "-enable-pretty-printing",
							ignoreFailures = false,
						},
						{
							description = "Set Disassembly Flavor to Intel",
							text = "-gdb-set disassembly-flavor intel",
							ignoreFailures = false,
						},
					},
				},
			}

			dap.configurations.cpp = debug_configurations
			dap.configurations.c = debug_configurations
			dap.configurations.rust = debug_configurations

			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						position = "left",
						size = 40,
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						position = "bottom",
						size = 10,
					},
				},
			})

			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
			)
			vim.fn.sign_define(
				"DapStopped",
				{ text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" }
			)

			vim.keymap.set("n", "<leader>dd", dapui.toggle, { desc = "Debug: Toggle UI" })
			vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<F1>", dap.continue, { desc = "Debug: Continue" })
			vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Debug: Step Out" })
			vim.keymap.set("n", "<leader>dk", dap.terminate, { desc = "Debug: Terminate" })

			require("mason-nvim-dap").setup({
				ensure_installed = { "cpptools" },
				automatic_installation = true,
			})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
