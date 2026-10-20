# ime-toggle

A tiny Neovim plugin: runs a command on `InsertLeave` to turn the IME off, and
optionally runs another on `InsertEnter` to turn it back on.

Works with anything you can drive from the shell: fcitx5, ibus, im-select, etc.
Tested with `fcitx5-remote` on Linux.

## Install

```lua
-- lazy.nvim
{
    "bactoeto/ime-toggle",
    config = function()
        require("ime-toggle").setup()
    end,
}
```
## Config

```lua
require("ime-toggle").setup({
    deactivate = "fcitx5-remote -c",     -- run on InsertLeave
    activate = "fcitx5-remote -s rime",  -- run on InsertEnter (only if enabled)
    query = "fcitx5-remote -n",          -- prints the current input method
    enabled = false,                     -- run activate on InsertEnter?
})
```

Defaults are for fcitx5 with the rime input method. Other examples:

```lua
-- fcitx5: just turn the current IME on/off
activate = "fcitx5-remote -o"

-- ibus
deactivate = "ibus engine xkb:us::eng"
activate = "ibus engine rime"
query = "ibus engine"

-- macOS
deactivate = "im-select com.apple.keylayout.ABC"
activate = "im-select com.apple.inputmethod.SCIM.ITABC"
query = "im-select"
```

`:ImeToggle` toggles the `InsertEnter` behavior at runtime.

## Statusline

`current()` returns the active input method name, e.g. `rime` (`keyboard-us`
when the IME is off). The result is cached for 500 ms.

```lua
-- lualine
{ function() return require("ime-toggle").current() end }

-- 'statusline'
vim.o.statusline = "%{v:lua.require'ime-toggle'.current()}"
```

## License

MIT
