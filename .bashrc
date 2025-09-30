# Short & sweet terminal prompt
parse_git_branch() {
    local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
    if [ -n "$branch" ]; then
        echo " $branch"
    fi
}
export PS1="\[\033[01;34m\]\w\[\e[91m\]\$(parse_git_branch)\[\033[00m\]\$ "

PROMPT_DIRTRIM=1

# Enable fzf for command line fuzzy search, if installed
if test -d ~/.fzf; then
    [ -f ~/.fzf.bash ] && source "${HOME}/.fzf.bash"
    source "${HOME}/.fzf/shell/key-bindings.bash"
fi

# Aliases
alias lg='lazygit'

# Launch dev container
function dev {
    IMAGE_ID="$(ls -id . | grep -Eo '[0-9]{1,}')"
    if ! docker build . -t "${IMAGE_ID}"; then
      echo "No Dockerfile for base image found! Using 'ubuntu' instead..."
      IMAGE_ID="ubuntu"
    fi
    cd ~/.dotfiles/docker || return
    docker build --build-arg IMAGE_ID="${IMAGE_ID}" -t "${IMAGE_ID}"-dev . 2>&1 | tee ~/.dotfiles/build-"${IMAGE_ID}".log
    cd - > /dev/null 2>&1 || return
    docker run --rm -it \
       --workdir=/app \
       --volume="$1":/app \
       --volume="$HOME"/.gitconfig:/root/.gitconfig \
       --volume="$HOME"/git-hooks:/root/git-hooks \
       --volume="$HOME"/.ssh:/root/.ssh \
       "${@:2}" \
       "${IMAGE_ID}"-dev:latest \
       bash
}

# Save path on cd
function cd {
    builtin cd "$@" || return
    pwd > ~/.last_dir
}

# cd to dotfiles directory
function dot {
    cd ~/.dotfiles || return
}

# Restore last saved path when open bash
if [ -f ~/.last_dir ]; then
    cd "$(cat ~/.last_dir)" || return
fi

# Add custom installs to PATH
export PATH=~/bin:$PATH

# Add Mason language servers to path
export PATH=~/.local/share/nvim/mason/bin:$PATH

# Add Alacritty to path
[ -f ~/.alacritty/extra/completions/alacritty.bash ] && source ~/.alacritty/extra/completions/alacritty.bash
