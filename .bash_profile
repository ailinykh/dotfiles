# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}' > /dev/null

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="/usr/local/opt/llvm/bin:$PATH"

export PATH=$HOME/Library/Python/3.7/bin:$PATH

cgif() {
  ffmpeg -i $1 -y -vf fps=10,scale=640:-1:flags=lanczos,palettegen palette.png
  ffmpeg -i $1 -i palette.png -filter_complex "fps=10,scale=640:-1:flags=lanczos[x];[x][1:v]paletteuse" "${1%.*}".gif 
  rm palette.png
}

