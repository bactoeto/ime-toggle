# ime-toggle

A tiny Neovim plugin that switches your input method (IME) off when you leave
insert mode, so normal-mode keys are never swallowed by a Chinese/Japanese/Korean
input method. Optionally, it can also turn the IME back on when you enter insert
mode.

It works by shelling out to [`fcitx5-remote`](https://github.com/fcitx/fcitx5),
so it is intended for Linux + fcitx5 users.

## Features

- Turns the IME off on `InsertLeave`.
- Optional: restores your IME on `InsertEnter` (off by default).
- Tiny (~40 lines), no dependencies beyond `fcitx5-remote`.
- Includes an `:ImeToggle` command to flip the restore-on-insert behavior at runtime.

## Requirements

- Neovim 0.7+
- fcitx5 with `fcitx5-remote` in your `$PATH`

Check that it works:

```sh
fcitx5-remote -c      # deactivate IME
fcitx5-remote -s rime # activate the "rime" input method
```

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "bactoeto/ime-toggle",
    config = function()
        require("ime-toggle").setup({
            ime_name = "rime",
        })
    end,
}
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use({
    "bactoeto/ime-toggle",
    config = function()
        require("ime-toggle").setup({ ime_name = "rime" })
    end,
})
```

Using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'bactoeto/ime-toggle'

lua << EOF
require("ime-toggle").setup({ ime_name = "rime" })
EOF
```

Or just drop `ime-toggle.lua` into your `lua/` directory and call `setup()`.

## Configuration

`setup()` is optional; it is only needed if you want to change the defaults.

```lua
require("ime-toggle").setup({
    cmd = "fcitx5-remote", -- command used to talk to the IME
    ime_name = "rime",     -- IME activated on InsertEnter, e.g. "rime", "mozc", "hangul"
    enabled = false,       -- activate the IME on InsertEnter? (default: false)
})
```

| Option     | Default           | Description                                                              |
| ---------- | ----------------- | ------------------------------------------------------------------------ |
| `cmd`      | `"fcitx5-remote"` | Command invoked for both activation and deactivation.                    |
| `ime_name` | `"rime"`          | Input method name passed to `fcitx5-remote -s`.                          |
| `enabled`  | `false`           | Whether entering insert mode reactivates the IME.                        |

Note that `InsertLeave` always deactivates the IME, regardless of `enabled`.

## Usage

| Action              | Result                                                     |
| ------------------- | ---------------------------------------------------------- |
| Leave insert mode   | IME is deactivated (`fcitx5-remote -c`).                    |
| Enter insert mode   | IME is reactivated (`fcitx5-remote -s <ime_name>`) **only if** `enabled` is true. |
| `:ImeToggle`        | Toggle whether entering insert mode reactivates the IME.    |

For example, to start with the IME reactivation enabled:

```lua
require("ime-toggle").setup({ ime_name = "rime", enabled = true })
```

and press `:ImeToggle` whenever you want to turn that behavior off again.

## How it works

The plugin creates an `ImeToggle` augroup with two autocommands:

- `InsertLeave` runs `<cmd> -c` to deactivate the IME.
- `InsertEnter` runs `<cmd> -s <ime_name>` when `enabled` is true.

The `:ImeToggle` user command flips the `enabled` flag and shows a notification.

## License

MIT
