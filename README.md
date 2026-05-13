# Simple configuration for nvim

## Installation

1. Delete old nvim config:

```shell
rm -rf ~/.config/nvim
```

2. Install new config from this repo:

```shell
git clone https://github.com/borogk/nvim.git ~/.config/nvim
```

## Nerd fonts

For the proper icon display in the terminal, download fonts from here https://github.com/ryanoasis/nerd-fonts.

One simple way to install the whole pack:

```shell
git clone https://github.com/ryanoasis/nerd-fonts.git --depth 1
cd nerd-fonts
./install.sh
```

After installing, configure your terminal of choice to use one of the fonts that has "Nerd Font" in the name.

## Kitty

Here are some quick steps to get [Kitty terminal](https://sw.kovidgoyal.net/kitty/) up to speed:

1. Run `kitten choose-fonts` to configure terminal font (current preference `RobotoMono Nerd Font`).
2. Run `kitten themes` to configure a theme (current preference `Catppuccin-Mocha`, [download separately here](https://github.com/catppuccin/kitty/blob/main/themes/mocha.conf)).
3. Append custom settings into `~/.config/kitty/kitty.conf`:

```
font_size               13.0

linux_display_server    x11
enabled_layouts         fat,horizontal

map kitty_mod+t         launch --cwd=current --type=tab --location=neighbor
map cmd+t               launch --cwd=current --type=tab --location=neighbor
map kitty_mod+enter     launch --cwd=current
map cmd+enter           launch --cwd=current
map kitty_mod+d         detach_window ask
map kitty_mod+m         move_window
```

## LSP

Although the necessary plugins for LSP are included in this repo, LSP servers must be installed separately via Mason.

Run `:Mason` command to bring up Mason UI with a list of implementations for various languages.
Press `g?` for help with what button to press to install/update etc.

## lazygit + delta

Install [lazygit](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation) to enable fancy git interface.

Additionally, install [delta](https://dandavison.github.io/delta/installation.html) for better diff visualization.

Lazygit configuration (see `config.yml` location in [docs](https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md)):

```yaml
git:
  pagers:
    - pager: delta --dark --paging=never
  log:
    showWholeGraph: true
```

## fd

Install [fd](https://github.com/sharkdp/fd?tab=readme-ov-file#installation) to enable quick file search in explorer picker.

## delve

Install [delve](https://github.com/go-delve/delve/tree/master/Documentation/installation) to enable Go debugging:

```sh
go install github.com/go-delve/delve/cmd/dlv@latest
```

Sample command that builds and starts an app with debug server ready to be attached:

```sh
dlv --listen=:2345 --headless debug
```

Full details can be looked up in the [usage documentation](https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv.md).

## edb

Install [edb](https://github.com/WhatsApp/edb) and add it to PATH to enable OTP/Erlang debugging.

Sample command to start an OTP node with debugging enabled:

```sh
# Debugger can only connect via longnames (node@host), therefore specifying -name is preferred over -sname
# Additionally, +D argument is crucial to enable debugging
erl -pa codepath -name test@localhost -setcookie test +D
```

Corresponding DAP configuration to attach debugger to above node (can be added to workspace's `.nvim.lua`):

```lua
local dap = require("dap")

dap.configurations.erlang = {
    {
        type = "edb",
        request = "attach",
        name = "Attach to test",
        config = {
            node = "test@localhost",
            cookie = "test",
            cwd = "${workspaceFolder}",
        }
    }
}
```

