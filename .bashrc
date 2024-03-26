# Short & sweet terminal prompt
export PS1="\[\033[01;34m\]\w\[\033[00m\]\$ "
PROMPT_DIRTRIM=1

# Enable fzf for command line fuzzy search, if installed
if test -d ~/.fzf; then
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
    source ~/.fzf/shell/key-bindings.bash
fi

# Aliases
alias lg='lazygit'

# Launch dev container
function dev {
    IMAGE_ID="$(ls -id . | grep -Eo '[0-9]{1,}')"
    if ! docker build . -t ${IMAGE_ID}; then
      echo "No Dockerfile for base image found! Using 'ubuntu' instead..."
      IMAGE_ID="ubuntu"
    fi
    cd ~/.dotfiles/docker
    docker build --build-arg IMAGE_ID=${IMAGE_ID} -t ${IMAGE_ID}-dev .
    cd - > /dev/null 2>&1
    docker run --rm -it \
       --workdir=/app \
       --volume="$1":/app \
       --volume="$HOME"/.gitconfig:/root/.gitconfig \
       --volume="$HOME"/.ssh:/root/.ssh \
       ${IMAGE_ID}-dev:latest
}

# Save path on cd
function cd {
    builtin cd $@
    pwd > ~/.last_dir
}

# Restore last saved path when open bash
if [ -f ~/.last_dir ]
    then cd `cat ~/.last_dir`
fi

# Add custom installs to PATH
export PATH=~/bin:$PATH
