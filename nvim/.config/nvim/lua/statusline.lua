local M = {}

M.stbufnr = function()
  local ok, buf = pcall(vim.api.nvim_win_get_buf, vim.g.statusline_winid or 0)
  return ok and buf or 0
end

M.is_activewin = function()
  local ok, win = pcall(vim.api.nvim_get_current_win)
  return ok and vim.g.statusline_winid and win == vim.g.statusline_winid or false
end

local orders = {
  default = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
  vscode = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cursor", "cwd" },
}

M.generate = function(theme, modules)
  local order = orders[theme] or orders.default
  local result = {}

  for _, v in ipairs(order) do
    local module_func_or_string = modules[v]
    local module_content = ""

    if module_func_or_string then
      if type(module_func_or_string) == 'function' then
        local ok, res = pcall(module_func_or_string)
        if ok then
          if type(res) == 'table' then
            module_content = table.concat(res, "")
          elseif type(res) == 'string' then
            module_content = res
          end
        else
          module_content = "%#St_Error#ModErr:" .. v .. "%*"
        end
      elseif type(module_func_or_string) == 'string' then
        module_content = module_func_or_string
      end
      table.insert(result, module_content)
    end
  end

  return table.concat(result)
end

M.modes = {
  ["n"] = { "NORMAL", "Normal" },
  ["no"] = { "NORMAL (no)", "Normal" },
  ["nov"] = { "NORMAL (nov)", "Normal" },
  ["noV"] = { "NORMAL (noV)", "Normal" },
  ["noCTRL-V"] = { "NORMAL", "Normal" },
  ["niI"] = { "NORMAL i", "Normal" },
  ["niR"] = { "NORMAL r", "Normal" },
  ["niV"] = { "NORMAL v", "Normal" },
  ["nt"] = { "NTERMINAL", "NTerminal" },
  ["ntT"] = { "NTERMINAL (ntT)", "NTerminal" },
  ["v"] = { "VISUAL", "Visual" },
  ["vs"] = { "V-CHAR (Ctrl O)", "Visual" },
  ["V"] = { "V-LINE", "Visual" },
  ["Vs"] = { "V-LINE", "Visual" },
  [" "] = { "V-BLOCK", "Visual" },
  ["i"] = { "INSERT", "Insert" },
  ["ic"] = { "INSERT (completion)", "Insert" },
  ["ix"] = { "INSERT completion", "Insert" },
  ["t"] = { "TERMINAL", "Terminal" },
  ["R"] = { "REPLACE", "Replace" },
  ["Rc"] = { "REPLACE (Rc)", "Replace" },
  ["Rx"] = { "REPLACEa (Rx)", "Replace" },
  ["Rv"] = { "V-REPLACE", "Replace" },
  ["Rvc"] = { "V-REPLACE (Rvc)", "Replace" },
  ["Rvx"] = { "V-REPLACE (Rvx)", "Replace" },
  ["s"] = { "SELECT", "Select" },
  ["S"] = { "S-LINE", "Select" },
  [" "] = { "S-BLOCK", "Select" },
  ["c"] = { "COMMAND", "Command" },
  ["cv"] = { "COMMAND", "Command" },
  ["ce"] = { "COMMAND", "Command" },
  ["cr"] = { "COMMAND", "Command" },
  ["r"] = { "PROMPT", "Confirm" },
  ["rm"] = { "MORE", "Confirm" },
  ["r?"] = { "CONFIRM", "Confirm" },
  ["x"] = { "CONFIRM", "Confirm" },
  ["!"] = { "SHELL", "Terminal" },
}

M.file = function()
  local icon = "󰈚"
  local buf = M.stbufnr()
  if buf == 0 then return { "?", "NoBuf" } end

  local path_ok, path = pcall(vim.api.nvim_buf_get_name, buf)
  if not path_ok or path == "" then return { "?", "NoName" } end

  local name = path:match "([^/\\]+)[/\\]*$" or path

  local devicons_present, devicons = pcall(require, "nvim-web-devicons")
  if devicons_present then
    local icon_ok, ft_icon = pcall(devicons.get_icon, name, path)
    if icon_ok and ft_icon then icon = ft_icon end
  end
  return { icon, name }
end

M.git = function()
  local MiniGit
  local git_present, _ = pcall(function() MiniGit = require('mini.git') end)
  if not git_present then return "" end

  local buf_id = M.stbufnr()
  if buf_id == 0 then return "" end

  local data_ok, data = pcall(MiniGit.get_buf_data, buf_id)
  if not data_ok or not data or not data.head_name then return "" end

  local branch_display = " " .. data.head_name
  local changes_str = ""

  local summary_ok, summary = pcall(function() return vim.b[buf_id].minidiff_summary end)

  if summary_ok and summary then
    local added = summary.add or 0
    local changed = summary.change or 0
    local deleted = summary.delete or 0

    if added > 0 then
      changes_str = changes_str .. " %#St_gitAdded# " .. added .. "%*"
    end
    -- Mostrar cambios ('~') solo si hay cambios y no solo adds/deletes
    if changed > 0 then
      changes_str = changes_str .. " %#St_gitChanged# " .. changed .. "%*" -- Highlight para cambios
    end
    if deleted > 0 then
      changes_str = changes_str .. " %#St_gitRemoved# " .. deleted .. "%*"
    end
    -- Añadir espacio separador si hay cambios
    if changes_str ~= "" then changes_str = " " .. changes_str end
  end

  return " " .. branch_display .. changes_str
end

M.lsp_msg = function()
  return M.state.lsp_msg or ""
end

M.lsp = function()
  local result = ""
  if rawget(vim, "lsp") then
    local buf = M.stbufnr()
    if buf ~= 0 then
      local clients = vim.lsp.get_clients({ bufnr = buf })
      if #clients > 0 then
        local client_names = {}
        for _, client in ipairs(clients) do table.insert(client_names, client.name) end
        local display_name = table.concat(client_names, ", ")
        result = (vim.o.columns > 100 and "  LSP " .. display_name .. " ") or "  LSP "
      end
    end
  end
  return result
end

M.diagnostics = function()
  local result = ""
  if rawget(vim, "lsp") then
    local buf = M.stbufnr()
    if buf ~= 0 then
      local diag_ok, diags_err = pcall(vim.diagnostic.get, buf, { severity = vim.diagnostic.severity.ERROR })
      local err = (diag_ok and #diags_err or 0)
      local diag_ok, diags_warn = pcall(vim.diagnostic.get, buf, { severity = vim.diagnostic.severity.WARN })
      local warn = (diag_ok and #diags_warn or 0)
      local diag_ok, diags_hints = pcall(vim.diagnostic.get, buf, { severity = vim.diagnostic.severity.HINT })
      local hints = (diag_ok and #diags_hints or 0)
      local diag_ok, diags_info = pcall(vim.diagnostic.get, buf, { severity = vim.diagnostic.severity.INFO })
      local info = (diag_ok and #diags_info or 0)

      local err_str = (err > 0) and ("%#St_lspError#" .. " " .. err .. " ") or ""
      local warn_str = (warn > 0) and ("%#St_lspWarning#" .. " " .. warn .. " ") or ""
      local hints_str = (hints > 0) and ("%#St_lspHints#" .. "󰛩 " .. hints .. " ") or ""
      local info_str = (info > 0) and ("%#St_lspInfo#" .. "󰋼 " .. info .. " ") or ""
      result = " " .. err_str .. warn_str .. hints_str .. info_str
    end
  end
  return result
end

M.separators = { default = { left = "", right = "" }, round = { left = "", right = "" }, block = { left = "█", right = "█" }, arrow = { left = "", right = "" }, }
M.state = { lsp_msg = "" }
local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥", "" }

-- Reemplaza la función M.autocmds existente con esta versión corregida:
M.autocmds = function()
  local group = vim.api.nvim_create_augroup("StatuslineLspProgress", { clear = true })
  vim.api.nvim_create_autocmd("LspProgress", {
    group = group,
    pattern = "*",
    callback = function(args)
      if not args.data or not args.data.params or not args.data.params.value then
        return
      end

      local value_data = args.data.params.value
      local title = value_data.title or ""
      local msg = value_data.message
      local percentage = value_data.percentage
      local kind = value_data.kind

      local progress_str = ""
      local loaded_count_str = ""

      if percentage then
        percentage = math.floor(percentage)
        local spinner_idx = math.max(1, math.min(#spinners, math.floor(percentage / 10) + 1))
        spinner_idx = math.max(1, math.min(#spinners, spinner_idx))
        if spinners[spinner_idx] then
          local icon = spinners[spinner_idx]
          -- >>> CORRECCIÓN AQUÍ: Usar %%%% para obtener %% en la salida <<<
          progress_str = string.format("%s %d%%%%", icon, percentage)
        else
          -- >>> CORRECCIÓN AQUÍ: Usar %%%% para obtener %% en la salida <<<
          progress_str = string.format("%d%%%%", percentage)
        end
      end

      if msg then
        local count_match = string.match(msg, "^(%d+/%d+)")
        if count_match then
          loaded_count_str = count_match
        end
      end

      local final_msg_parts = {}
      if progress_str ~= "" then table.insert(final_msg_parts, progress_str) end
      if title ~= "" then table.insert(final_msg_parts, title) end
      if loaded_count_str ~= "" then table.insert(final_msg_parts, loaded_count_str) end

      local status_msg = table.concat(final_msg_parts, " ")

      if status_msg ~= "" then
        M.state.lsp_msg = status_msg
      elseif kind == 'end' or (args.data.token and args.data.done) then
        M.state.lsp_msg = ""
      end

      if status_msg ~= "" or kind == 'end' or (args.data.token and args.data.done) then
        pcall(vim.cmd, "redrawstatus")
      end

      local comparison_msg = (status_msg == "") and M.state.lsp_msg or status_msg
      if kind == 'end' or (args.data.token and args.data.done) then
        vim.defer_fn(function()
          if M.state.lsp_msg == comparison_msg then
            M.state.lsp_msg = ""
            pcall(vim.cmd, "redrawstatus")
          end
        end, 500)
      end
    end,
  })
end

local utils = M
local stl = {}

stl.mode = function()
  local mode_ok, mode_info = pcall(vim.api.nvim_get_mode)
  if not mode_ok then return "%#St_Error#ModeErr%*" end
  if not utils.is_activewin() then return "" end

  local modes = utils.modes
  local m = mode_info.mode
  if modes[m] and modes[m][1] and modes[m][2] then
    return "%#St_" .. modes[m][2] .. "mode#" .. "  " .. modes[m][1] .. " "
  else
    return "%#St_Normalmode#  UNKNOWN "
  end
end

stl.file = function()
  local file_info_ok, file_info = pcall(utils.file)
  if not file_info_ok or not file_info then return "%#St_Error#FileErr%*" end
  if type(file_info) == 'table' and #file_info == 2 then
    local name = " " .. file_info[2] .. " "
    return "%#StText#" .. file_info[1] .. name
  else
    return "%#St_Error#FileFmtErr%*"
  end
end

stl.git = utils.git
stl.lsp_msg = utils.lsp_msg
stl.diagnostics = utils.diagnostics
stl.lsp = function()
  local lsp_str_ok, lsp_str = pcall(utils.lsp)
  if lsp_str_ok and lsp_str and lsp_str ~= "" then
    return "%#St_Lsp#" .. lsp_str
  else
    return ""
  end
end
-- stl.cursor = "%#StText# Ln %l, Col %v "
stl["%="] = "%="

stl.cwd = function()
  local ok, name = pcall(vim.uv.cwd)
  if not ok or not name then return "" end
  local basename = name:match(".+[/\\]([^/\\]+)$") or name
  local cwd_str = "%#St_cwd# 󰉖 " .. basename .. " "
  return (vim.o.columns > 85 and cwd_str) or ""
end

local generate_stl_statusline = function()
  local ok, result = pcall(utils.generate, "vscode", stl)
  if ok then
    return type(result) == 'string' and result or "%#St_Error#ResultNotString%*"
  else
    return "%#St_Error#Error generating statusline%*"
  end
end

if utils and type(utils.autocmds) == 'function' then
  pcall(utils.autocmds)
end

return generate_stl_statusline
