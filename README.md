# ime-toggle

A tiny Neovim plugin: runs a command on `InsertLeave` to turn the IME off, and
optionally runs another on `InsertEnter` to turn it back on.

Works with anything you can drive from the shell: fcitx5, ibus, im-select, etc.

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
    deactivate = "fcitx5-remote -c", -- run on InsertLeave
    activate = "fcitx5-remote -o",   -- run on InsertEnter (only if enabled)
    enabled = false,                 -- run activate on InsertEnter?
})
```

Defaults are for fcitx5. Other examples:

```lua
-- fcitx5, a specific input method
activate = "fcitx5-remote -s rime"

-- ibus
deactivate = "ibus engine xkb:us::eng"
activate = "ibus engine rime"

-- macOS
deactivate = "im-select com.apple.keylayout.ABC"
activate = "im-select com.apple.inputmethod.SCIM.ITABC"
```

`:ImeToggle` toggles the `InsertEnter` behavior at runtime.

## License

MIT
