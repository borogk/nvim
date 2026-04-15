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

## LSP

Although the necessary plugins for LSP are included in this repo, LSP servers must be installed separately via Mason.

Run `:Mason` command to bring up Mason UI with a list of implementations for various languages.
Press `g?` for help with what button to press to install/update etc.

## lazygit + delta

Install [lazygit](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation) to enable fancy git interface.

Additionally, install [delta](https://dandavison.github.io/delta/installation.html) for better diff visualization.

After installing, [configure lazygit](https://github.com/jesseduffield/lazygit/blob/master/docs/Custom_Pagers.md#delta) to use it.

## fd

Install [fd](https://github.com/sharkdp/fd?tab=readme-ov-file#installation) to enable quick file search in explorer picker.

