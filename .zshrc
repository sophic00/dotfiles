# zmodload zsh/zprof

DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# --- ZSH optmizations ---
autoload -Uz compinit
# Check if .zcompdump was created today. If not, regenerate it.
if [[ -z ~/.zcompdump(#qN.md-1) ]]; then
  compinit
else
  # Load from cache without security checks for speed
  compinit -C
fi
# --- END OF CODE ---

export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.config/emacs/bin:$PATH"
ZSH_THEME=""

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export EDITOR="nvim"

# colorful ls
if command -v vivid >/dev/null 2>&1; then
  export LS_COLORS="$(vivid generate molokai)"
fi

# random fastfetch config which on ghostty
if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
  rand=$(( (RANDOM % 8) + 1 ))
  fastfetch -c "$HOME/.config/fastfetch/makima${rand}.jsonc"
fi

# starship prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# zoxide -- smarter cd
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# zellij -- terminal multiplexer
# if command -v zellij >/dev/null 2>&1; then
#   eval "$(zellij setup --generate-auto-start zsh)"
# fi

. "$HOME/.cargo/env"
eval "$(gh copilot alias -- zsh)"

# Source all files in ~/.zshrc.d
for rcfile in /home/vaibhav/.config/zshrc/*.zsh; do
  source "$rcfile"
done

# alias conda="$HOME/miniforge3/bin/conda"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!

# Lazy load conda
conda() {
    unset -f conda
    
    __conda_setup="$('/home/vaibhav/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/vaibhav/miniforge3/etc/profile.d/conda.sh" ]; then
            . "/home/vaibhav/miniforge3/etc/profile.d/conda.sh"
        else
            export PATH="/home/vaibhav/miniforge3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    
    conda "$@"
}

# <<< conda initialize <<<


## [Completion]
## Completion scripts setup. Remove the following line to uninstall
# [[ -f /home/vaibhav/.dart-cli-completion/zsh-config.zsh ]] && . /home/vaibhav/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]



# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
 [[ ! -r '/home/vaibhav/.opam/opam-init/init.zsh' ]] || source '/home/vaibhav/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

# pnpm
export PNPM_HOME="/home/vaibhav/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# ZVM
export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
source <(COMPLETE=zsh jj)
# source /usr/share/fzf/key-bindings.zsh
# source /usr/share/fzf/completion.zsh

# direnv setup
eval "$(direnv hook zsh)"


# Path to binary installed using golang
export PATH="$PATH:$HOME/go/bin"

# leetcode cli completions
if command -v leetcode >/dev/null 2>&1; then
  eval "$(leetcode completions zsh)"
fi

# yazi 
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Function to update all custom OMZ plugins
omzplug_update() {
  # Check if the custom plugins directory exists
  if [ ! -d "$ZSH/custom/plugins" ]; then
    echo "No custom plugins directory found."
    return
  fi

  echo "Updating custom Oh My Zsh plugins..."
  # Loop through each directory in the custom plugins folder
  for plugin_dir in $ZSH/custom/plugins/*; do
    # Check if it's a directory and contains a .git folder
    if [ -d "$plugin_dir" ] && [ -d "$plugin_dir/.git" ]; then
      local plugin_name=$(basename "$plugin_dir")
      echo "--> Updating ${plugin_name}..."
      (cd "$plugin_dir" && git pull)
    fi
  done
  echo "Custom plugins update complete."
}
# zprof
