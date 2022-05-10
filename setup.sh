#!/usr/bin/bash

echo -e '\033[0;32mSetting up... \u23f3'

creteIfNotExists() {

    path=$2$1

    if [[ ! -e "$path" ]]; then

        mkdir -p "$2"

        touch "$path"

    fi

}

creteIfNotExists ".bash_profile" "$HOME/"

cat <<EOT >>~/.bash_profile

# Source the ~/.bashrc file if it exists

if [ -f ~/.bashrc ]

then

    . ~/.bashrc

fi

EOT

creteIfNotExists ".bashrc" "$HOME/"

cat <<EOT >>~/.bashrc

# Git aliases

alias gs='git status -sb'

alias gcc='git checkout'

alias gcm='git checkout master'

alias gaa='git add --all'

alias gc='git commit -m \$2'

alias push='git push'

alias gpo='git push origin'

alias pull='git pull'

alias clone='git clone'

alias stash='git stash'

alias pop='git stash pop'

alias ga='git add'

alias gb='git branch'

alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias gm='git merge'


# Bash aliases

alias .='cd .'

alias ..='cd ..'

alias ...='cd ../../'

alias ....='cd ../../../'

alias .....='cd ../../../../'

alias bashclear='echo "" > ~/.bash_history'

alias cls='clear'

alias ls='ls -F --color=auto --show-control-chars'

alias ll='ls -l'

alias ll.='ls -la'

alias lls='ls -la --sort=size'

alias llt='ls -la --sort=time'

alias rm='rm -iv'

alias work='cd /c/repos'


# Bash shell settings

# Typing a directory name just by itself will automatically change into that directory.

shopt -s autocd


# Automatically fix directory name typos when changing directory.

shopt -s cdspell


# Automatically expand directory globs and fix directory name typos whilst completing.

# Note, this works in conjuction with the cdspell option listed above.

shopt -s direxpand dirspell


# Enable the ** globstar recursive pattern in file and directory expansions.

# For example, ls **/*.txt will list all text files in the current directory hierarchy.

shopt -s globstar


# Ignore lines which begin with a <space> and match previous entries.

# Erase duplicate entries in history file.

HISTCONTROL=ignoreboth:erasedups


# Ignore saving short- and other listed commands to the history file.

HISTIGNORE=?:??:history


# The maximum number of lines in the history file.

HISTFILESIZE=99999


# The number of entries to save in the history file.

HISTSIZE=99999


# Set Bash to save each command to history, right after it has been executed.

PROMPT_COMMAND='history -a'


# Save multi-line commands in one history entry.

shopt -s cmdhist


# Append commands to the history file, instead of overwriting it.

# History substitution are not immediately passed to the shell parser.

shopt -s histappend histverify

EOT

creteIfNotExists "git-prompt.sh" "$HOME/.config/git/"

cat <<EOT >>~/.config/git/git-prompt.sh

# Custom prompt settings

PROMPT_DIRTRIM=4                         # Shorten deep paths in the prompt

PS1='\[\033]0;Git | Bash v\v | \W\007\]' # set window title

PS1="$PS1"'\n'                           # new line

PS1="$PS1"'\[\033[30;45m\] [\A] '        # black text, magenta, 24h time

PS1="$PS1"'\[\033[30;42m\] \u '          # black text, green, user

#PS1="$PS1"'\[\033[30;42m\]@\h '          # black text, green, @host

PS1="$PS1"'\[\033[30;43m\] \w '          # black text, yellow, working director

if test -z "$WINELOADERNOEXEC"

then

    GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"

    COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"

    COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"

    COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"

    if test -f "$COMPLETION_PATH/git-prompt.sh"

    then

        . "$COMPLETION_PATH/git-completion.bash"

        . "$COMPLETION_PATH/git-prompt.sh"

        PS1="$PS1"'\[\033[97;46m\]'  # white text, cyan

        PS1="$PS1"'$(__git_ps1)'      # bash function

    fi

fi

PS1="$PS1"'\[\033[0m\]'        # change color

PS1="$PS1"'\n'                 # new line

PS1="$PS1"'$ '                 # prompt: always $


# Git status options

# Shows * or + for unstaged and staged changes, respectively.

export GIT_PS1_SHOWSTASHSTATE=true


# shows $ if there are any stashes.

export GIT_PS1_SHOWDIRTYSTATE=true


# Shows % if there are any untracked files.

export GIT_PS1_SHOWUNTRACKEDFILES=true


# shows <, >, <>, or = when your branch is behind, ahead, diverged from,

# or in sync with the upstream branch, respectively.

export GIT_PS1_SHOWUPSTREAM="auto"

EOT

creteIfNotExists ".inputrc" "$HOME/"

cat <<EOT >>~/.inputrc

# Disable beeps & bells, and do not display control characters.

set bell-style none

set echo-control-characters off


# The TAB key cycles forward through the completion choices.

# Press an arrow key, such as right-arrow, to choose a selection.

TAB: menu-complete


# The Shift-TAB key cycles backward through the completion choices.

# Like TAB, press an arrow key, such as right-arrow, to choose a selection.

"\e[Z": menu-complete-backward


# The first TAB key press will display a list that match the given prefix.

# The next TAB key press will start cycling through the available choices.

set menu-complete-display-prefix on


# Display completion matches upon the first press of the TAB key.

#set show-all-if-ambiguous on


#Enable colors when completing filenames and directories.

set colored-stats on


# Completion matches of multiple items highlight the matching prefix in color.

set colored-completion-prefix on


# Ignore case when completing.

set completion-ignore-case on


# Treat hypens and underscores as equivalent when completing.

set completion-map-case on


# Append the / character to the end of symlinked directories when completing.

set mark-symlinked-directories on


# Enable incremental history navigation with the UP and DOWN arrow keys.

# This will use the already typed text as a required prefix.

"\e[A": history-search-backward

"\e[B": history-search-forward

EOT

echo 'Done!'

echo -e '\033[0;32mEnjoy your customized Git Bash Shell\033[0;32m \U1f44d'
