# Dotfiles

Bootstrap scripts for setting up a fresh Ubuntu/Debian-style machine.

## Fresh install

Install `curl`, then download and run the bootstrap script from GitHub:

```bash
sudo apt update
sudo apt install -y curl
curl -fsSL https://raw.githubusercontent.com/cjhelms/dotfiles/main/scripts/bootstrap.sh | bash
```

Running without arguments installs all targets:

- `core`: dotfile symlinks, Git, tmux, fzf, ripgrep, Node.js, Neovim, common LSP tools, and lazygit
- `desktop`: GNOME Terminal colors and GNOME extension tools

## Install a specific target

Pass targets after `bash -s --`:

```bash
curl -fsSL https://raw.githubusercontent.com/cjhelms/dotfiles/main/scripts/bootstrap.sh | bash -s -- core
```

Available targets:

- `all`: install core and desktop tools
- `core`: install dotfile symlinks, Git, tmux, fzf, ripgrep, Node.js, Neovim, common LSP tools, and lazygit
- `desktop`: install GNOME extension tools
- `dotfiles`: symlink dotfiles into the home directory with GNU Stow
- `git`: install Git and configure identity/key
- `tmux`: install tmux
- `fzf`: install fzf
- `ripgrep`: install ripgrep
- `node`: install nvm and Node.js
- `neovim`: install Neovim
- `lsp`: install common Neovim LSP servers and formatters
- `lazygit`: install lazygit
- `terminal_theme`: configure GNOME Terminal habamax colors
- `gnome_extensions`: install GNOME extension tools

## How curl bootstrap works

When `bootstrap.sh` is run outside the dotfiles repo, it:

1. Installs `git` if it is missing.
2. Clones `https://github.com/cjhelms/dotfiles.git` into `~/.dotfiles` if that path does not exist.
3. Exits if `~/.dotfiles` already exists but is not a Git checkout.
4. Re-runs `~/.dotfiles/scripts/bootstrap.sh` with the same arguments.

After the repo exists locally, you can run targets directly:

```bash
bash ~/.dotfiles/scripts/bootstrap.sh core
```

## Notes

- The scripts assume an `apt`-based Linux distribution and require `sudo`.
- Dotfiles are symlinked with GNU Stow from `~/.dotfiles` into `~`.
- Binaries are installed or linked under `~/bin`; make sure `~/bin` is on your `PATH`.
- Some installers update shell configuration. Restart your shell after the bootstrap completes.
