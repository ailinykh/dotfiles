# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker)

source $ZSH/oh-my-zsh.sh

if [ -f ~/.bash_profile ]; then
  source ~/.bash_profile
fi

# User configuration

git_cherry_pick() {
  [ $# -lt 1 ] && echo "$0 commit_hash [destination_branch=master]" && return 1
  local BRANCH=${2:-master}
  
  git checkout -b user/ilinykh/cherry_pick_$1_to_$BRANCH $BRANCH
  [ $? != 0 ] && return 1

  git cherry-pick $1
  [ $? != 0 ] && return 1

  git push origin HEAD
  [ $? != 0 ] && return 1

  git checkout master
}

rmt() { [ $# -lt 1 ] && echo "$0 filename" && return 1; cat $1 | grep -v '\trmt\t' >> "${1%.*}_rmt.log" }

# ffmpeg aliases

c480 () { for f in $@; do; ffmpeg -v error -stats -i "${f}" -map_metadata 0:g -s hd480 -c:v libx264 -crf 23 -c:a aac -strict -2 "`basename ${f%.*}`".480.mp4; done; }
c720 () { for f in $@; do; ffmpeg -v error -stats -i "${f}" -map_metadata 0:g -s hd720 -c:v libx264 -crf 23 -c:a aac -strict -2 "`basename ${f%.*}`".720.mp4; done; }
c1080 () { for f in $@; do; ffmpeg -v error -stats -i "${f}" -map_metadata 0:g -s hd1080 -c:v libx264 -crf 23 -c:a aac -strict -2 "`basename ${f%.*}`".1080.mp4; done; }

cipad () { for f in $@; do; ffmpeg -v error -stats -i "${f}" -map_metadata 0:g -acodec aac -ac 2 -strict experimental -ab 160k -s 1024x768 -vcodec libx264 -preset slow -profile:v baseline -level 30 -maxrate 10000000 -bufsize 10000000 -b 1200k -f mp4 -threads 0 "`basename ${f%.*}`".iPad.mp4; done; }

cgif () { ffmpeg -v error -stats -i $1 -y -vf fps=10,scale=640:-1:flags=lanczos,palettegen palette.png && ffmpeg -v error -stats -i $1 -i palette.png -filter_complex "fps=10,scale=640:-1:flags=lanczos[x];[x][1:v]paletteuse" "${1%.*}".gif && rm palette.png  }

ccut() {
    if [ $# -lt 2 ]; then
        echo "usage:"
        echo "ccut <seconds> <file1> [<file2>, <file3>, ...]"
        echo "or"
        echo "ccut <start time> <seconds> <file1>"
        echo ""
        echo "ccut 00:10:00 60 movie.mp4"
        return 1
    fi

    if [[ $1 =~ ^([0-9][0-9]:){2}[0-9][0-9]$ ]]; then
        ffmpeg -map_metadata 0:g -ss $1 -i $3 -c copy -t $2 "${3%.*}".$2sec.mp4
    else
        INTERVAL=$1

        for f in $@; do
            if [ -f $f ]; then
                DURATION=`ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 ${f} | sed 's/\..*//'`
                OFFSET=0
                while [ $OFFSET -lt $DURATION ]; do
                    echo "converting $f from $OFFSET interval $INTERVAL to ${f%.*}.$OFFSET.mp4"
                    ffmpeg -ss $OFFSET -i $f -c copy -t $INTERVAL "${f%.*}".$OFFSET.mp4
                    OFFSET=$(($OFFSET+$INTERVAL))
                done
            fi
        done
    fi
}

# VSCode alias

code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# Docker alias
drm() { docker rm $(docker ps -a -q); }
dri() { docker rmi $(docker images -q); }

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/usr/local/opt/node@16/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/Users/a.ilynikh/.mint/bin:$PATH"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
