local defaults = {
    -- run on InsertEnter when enabled
    activate = "fcitx5-remote -s rime",
    -- run on InsertLeave
    deactivate = "fcitx5-remote -c",
    -- prints the current input method
    query = "fcitx5-remote -n",
    enabled = false,
}

local config = vim.deepcopy(defaults)
local cache = { value = "", at = -math.huge }
local ttl = 500

local function run(cmd)
    if cmd ~= "" then
        vim.fn.system(cmd)
        cache.at = -math.huge
    end
end

local function setup(opts)
    config = vim.tbl_extend("force", defaults, opts or {})
    cache.at = -math.huge

    local group = vim.api.nvim_create_augroup("ImeToggle", { clear = true })
    vim.api.nvim_create_autocmd("InsertLeave", {
        group = group,
        callback = function() run(config.deactivate) end,
    })
    vim.api.nvim_create_autocmd("InsertEnter", {
        group = group,
        callback = function()
            if config.enabled then run(config.activate) end
        end,
    })
    vim.api.nvim_create_user_command("ImeToggle", function()
        config.enabled = not config.enabled
        vim.notify("ime-toggle: " .. (config.enabled and "on" or "off"))
    end, { desc = "Toggle IME activation on InsertEnter" })
end

-- Current input method name, e.g. "rime" (or "keyboard-us" when off).
local function current()
    if config.query == "" then
        return ""
    end
    local now = vim.loop.now()
    if now - cache.at < ttl then
        return cache.value
    end
    local out = vim.fn.system(config.query)
    cache.value = vim.v.shell_error == 0 and vim.trim(out) or ""
    cache.at = now
    return cache.value
end

return { setup = setup, current = current }
