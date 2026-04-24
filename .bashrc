# Only configure interactive shells.
case $- in
    *i*) ;;
    *) return ;;
esac

path_prepend() {
    case ":${PATH}:" in
        *":$1:"*) ;;
        *) PATH="$1:${PATH}" ;;
    esac
}

parse_git_branch() {
    local branch

    branch=$(git branch --show-current 2>/dev/null) || return
    [ -n "$branch" ] && printf ' (%s)' "$branch"
}

last_dir_file() {
    if [ -n "${TMUX:-}" ] && command -v tmux >/dev/null 2>&1; then
        printf '%s/.last_dir_tmux_%s' "${HOME}" "$(tmux display-message -p '#I')"
    else
        printf '%s/.last_dir' "${HOME}"
    fi
}

save_last_dir() {
    local state_file

    state_file="$(last_dir_file)"
    pwd > "$state_file"
}

restore_last_dir() {
    local state_file

    state_file="$(last_dir_file)"
    [ -f "$state_file" ] && builtin cd "$(cat "$state_file")" 2>/dev/null || true
}

cd() {
    builtin cd "$@" || return
    save_last_dir
}

dot() {
    cd "${HOME}/.dotfiles" || return
}

if [ -f "${HOME}/.fzf.bash" ]; then
    source "${HOME}/.fzf.bash"
elif [ -f "${HOME}/.fzf/shell/key-bindings.bash" ]; then
    source "${HOME}/.fzf/shell/key-bindings.bash"
fi

alias lg='lazygit'

PROMPT_DIRTRIM=1
PS1='\[\033[01;34m\]\w\[\e[91m\]$(parse_git_branch)\[\033[00m\]\$ '

path_prepend "${HOME}/bin"
path_prepend "${HOME}/.local/share/nvim/mason/bin"
export PATH

restore_last_dir
