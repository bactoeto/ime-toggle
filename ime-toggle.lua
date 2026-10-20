local defaults = {
    -- run on InsertEnter when enabled
    activate = "fcitx5-remote -s rime",
    -- run on InsertLeave
    deactivate = "fcitx5-remote -c",
    enabled = false,
}

local config = {}

local function run(cmd)
    if cmd ~= "" then
        vim.fn.system(cmd)
    end
end

local function setup(opts)
    config = vim.tbl_extend("force", defaults, opts or {})

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

return { setup = setup }
