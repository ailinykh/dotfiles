
7zax() {
  7za x $1 -o${1%.*}
}

# Set PS1
get_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\[\033[34m\]\w\[\033[32m\]\$(get_git_branch)\[\033[00m\] $ "

# Map CTRL to CapsLock
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}' > /dev/null

cgif() {
  ffmpeg -i $1 -y -vf fps=10,scale=640:-1:flags=lanczos,palettegen palette.png
  ffmpeg -i $1 -i palette.png -filter_complex "fps=10,scale=640:-1:flags=lanczos[x];[x][1:v]paletteuse" "${1%.*}".gif 
  rm palette.png
}
