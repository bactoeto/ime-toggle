# ime-toggle

A tiny Neovim plugin: turns the IME off on `InsertLeave`, and optionally back on
on `InsertEnter`. 

Tested with `fcitx5-remote` int Linux.

## Install

```lua
-- lazy.nvim
{
    "bactoeto/ime-toggle",
    config = function()
        require("ime-toggle").setup({ ime_name = "rime" })
    end,
}
```

## Config

```lua
require("ime-toggle").setup({
    cmd = "fcitx5-remote", -- command used to talk to the IME
    ime_name = "rime",     -- IME activated on InsertEnter
    enabled = false,       -- activate the IME on InsertEnter? (default: false)
})
```

`:ImeToggle` toggles the `InsertEnter` behavior at runtime.

Requires Neovim 0.7+ and `fcitx5-remote` in `$PATH`.

## License

MIT
