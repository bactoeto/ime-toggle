# ime-toggle

Tiny Neovim plugin: turns the IME off on `InsertLeave`, and optionally back on
on `InsertEnter`.

## Install

```lua
{
    "bactoeto/ime-toggle",
    config = function() require("ime-toggle").setup() end,
}
```

## Config

```lua
require("ime-toggle").setup({
    deactivate = "fcitx5-remote -c",     -- InsertLeave
    activate = "fcitx5-remote -s rime",  -- InsertEnter, if enabled
    query = "fcitx5-remote -n",          -- current input method
    enabled = false,
})
```

Defaults are for fcitx5 with rime; change the commands for ibus, im-select, etc.
`:ImeToggle` toggles `enabled` at runtime.

## Statusline

```lua
require("ime-toggle").current() -- "rime", or "none" when the IME is off
```

```lua
vim.o.statusline = "%{v:lua.require'ime-toggle'.current()}"
```

MIT.
