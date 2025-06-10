# --- p10k ---
# alles, was passwoerter oder anderen konsoleninput braucht, muss hiervor stehen
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- ghcup (haskell)---
[ -f "/Users/jakob/.ghcup/env" ] && . "/Users/jakob/.ghcup/env" # ghcup-envsourcesource

# --- pyenv (python)---
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# --- ruby ---
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

# --- p10k theme ---
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- plugins ---
fpath=(/opt/homebrew/share/zsh-completions/ $fpath) # ich verstehe dieses plugin nicht
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(zoxide init --cmd cd zsh)"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- History ---
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt APPENDHISTORY
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.



# --- fzf ---
eval "$(fzf --zsh)"
# ctrt-t oeffnet fzf
# ctrl-r sucht in command history
# ** -> tab  nach einem befehl wie zed, ssh oder kill -9 filter nach jeweils passenden ergebnissen
# ctrl-j/k/n/p um im preview zu navigieren
# tab/shift-tab  markiert ergebnisse
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git" #fd anstatt find
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND" #fd anstatt find
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git" # fd anstatt find
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# --- yazi ---
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
	    builtin cd -- "$cwd"  #ignoriert custom 'cd' commands
		#cd -- "$cwd" #nutzt meinen zoxide cd command, damit directories in meiner zoxide history sind
	fi
	rm -f -- "$tmp"
}

# --- tetris ---
export PATH="/Users/jakob/.local/bin:$PATH"
alias tetris="tetris --preview-chars '[]'"

# --- aliasse und keybinds ---
alias zedi='zed $(fzf -m --preview="bat --color=always {}")' #oeffne file in zed editor
alias opi='open $(fzf -m)' #oeffne files mit standardapp des files
alias calc="bc --scale=10 -l" #startet bc mit guter taschenrechnerkonfiguration
bindkey '^H' autosuggest-accept # binded ctrl h auf autocomplete fuer autosuggestions
alias please="sudo"
