# --- p10k ---
# alles, was passwoerter oder anderen konsoleninput braucht, muss hiervor stehen
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- ghcup ---
[ -f "/Users/jakob/.ghcup/env" ] && . "/Users/jakob/.ghcup/env" # ghcup-envsourcesource

# --- pyenv ---
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
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt=appendhistory
setopt=sharehistory
setopt=hist_ignore_space
setopt=hist_ignore_all_dups
setopt=hist_save_no_dups

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

# --- aliasse ---
alias zedi='zed $(fzf -m --preview="bat --color=always {}")' #oeffne file in zed editor
alias opi='open $(fzf -m)' #oeffne files mit standardapp des files
alias startai="ollama run deepseek-r1:7b" #startet ki in ollama
alias runol="brew services run ollama" #startet ollama
alias killol="brew services kill ollama" #killt ollama (geht nur so halb)
alias stopol="brew services stop ollama" #stoppt ollama
alias calc="bc -z --scale=10 -l"
