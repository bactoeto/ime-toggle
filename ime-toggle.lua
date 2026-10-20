local M = {}

local defaults = {
    -- command run on InsertEnter when enabled
    activate = "fcitx5-remote -o",
    -- command run on InsertLeave
    deactivate = "fcitx5-remote -c",
    -- whether InsertEnter runs the activate command
    enabled = false,
}

local config = {}
local enabled = false

local function run(cmd)
    if cmd and cmd ~= "" then
        vim.fn.system(cmd)
    end
end

local function set_enabled(value)
    enabled = not not value
    vim.notify("ime-toggle: " .. (enabled and "on" or "off"))
end

function M.setup(opts)
    config = vim.tbl_deep_extend("force", defaults, opts or {})
    enabled = config.enabled

    local group = vim.api.nvim_create_augroup("ImeToggle", { clear = true })

    vim.api.nvim_create_autocmd("InsertLeave", {
        group = group,
        callback = function()
            run(config.deactivate)
        end,
    })

    vim.api.nvim_create_autocmd("InsertEnter", {
        group = group,
        callback = function()
            if enabled then
                run(config.activate)
            end
        end,
    })

    vim.api.nvim_create_user_command("ImeToggle", function()
        set_enabled(not enabled)
    end, { desc = "Toggle IME activation on InsertEnter" })
end

return M
