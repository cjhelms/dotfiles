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
docker run --rm -it \
   --workdir=/app \
   --volume="$PWD":/app \
   --volume="$HOME"/.gitconfig:/root/.gitconfig \
   --volume="$HOME"/.ssh:/root/.ssh \
   development-container:latest
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
