local M = {}

local defaults = {
    cmd = "fcitx5-remote",
    ime_name = "rime",  -- override via setup(), e.g. "rime", "mozc", "hangul"
    enabled = false,       -- whether InsertEnter activates the IME
}

local config = {}
local enabled = false

local function set_enabled(value)
    enabled = not not value
    vim.notify("ime-toggle: " .. (enabled and config.ime_name or "off"))
end

function M.setup(opts)
    config = vim.tbl_deep_extend("force", defaults, opts or {})
    enabled = config.enabled

    local group = vim.api.nvim_create_augroup("ImeToggle", { clear = true })

    vim.api.nvim_create_autocmd("InsertLeave", {
        group = group,
        callback = function()
            vim.fn.system(config.cmd .. " -c")
        end,
    })

    vim.api.nvim_create_autocmd("InsertEnter", {
        group = group,
        callback = function()
            if enabled then
                vim.fn.system(config.cmd .. " -s " .. config.ime_name)
            end
        end,
    })

    vim.api.nvim_create_user_command("ImeToggle", function()
        set_enabled(not enabled)
    end, { desc = "Toggle IME activation on InsertEnter" })
end

return M
