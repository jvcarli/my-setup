# my setup

Personal setup notes and dotfiles for Arch Linux and macOS Ventura.

## Requirements

- Git
- GNU Stow

## Installation

```bash
git clone https://github.com/jvcarli/my-setup ~/dotfiles
```

Change directory and update git submodules:

```bash
cd ~/dotfiles
```

```bash
  $ git submodule update --remote --merge
```

Finally install the dotfiles. Currently this
assumes a clean environment. The managed
files and directories must not exist, otherwise
`stow` will give errors. In the future this will
be addressed.

```bash
./setup.sh --clean --install`
```
