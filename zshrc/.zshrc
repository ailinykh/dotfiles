export EDITOR="nvim"
export VISUAL="$EDITOR"

if [[ -n "$TMUX" ]]; then
  autoload -Uz add-zsh-hook

  tmux_command_title() {
    local -a words
    words=(${(z)1})
    tmux set-window-option automatic-rename off
    tmux rename-window -- "${words[1]:t}"
  }

  tmux_prompt_title() {
    tmux set-window-option automatic-rename on
  }

  add-zsh-hook preexec tmux_command_title
  add-zsh-hook precmd tmux_prompt_title
fi

# starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

# Ghostty CLI (macOS app bundle)
if [[ -d /Applications/Ghostty.app/Contents/MacOS ]]; then
  export PATH="/Applications/Ghostty.app/Contents/MacOS:$PATH"
fi

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"
