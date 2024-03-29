# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^U' backward-kill-line                   # ctrl + U
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# force zsh to show the complete history
alias history="history 0"

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

configure_prompt() {
    prompt_symbol=㉿
    # Skull emoji for root terminal
    #[ "$EUID" -eq 0 ] && prompt_symbol=💀
    case "$PROMPT_ALTERNATIVE" in
        twoline)
            PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}(%B%F{%(#.red.blue)}%n'$prompt_symbol$'%m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
            # Right-side prompt with exit codes and background processes
            #RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'
            ;;
        oneline)
            PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{%(#.red.blue)}%n@%m%b%F{reset}:%B%F{%(#.blue.green)}%~%b%F{reset}%(#.#.$) '
            RPROMPT=
            ;;
        backtrack)
            PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{red}%n@%m%b%F{reset}:%B%F{blue}%~%b%F{reset}%(#.#.$) '
            RPROMPT=
            ;;
    esac
    unset prompt_symbol
}

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    configure_prompt

    # enable syntax-highlighting
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
        ZSH_HIGHLIGHT_STYLES[default]=none
        ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
        ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[path]=bold
        ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[command-substitution]=none
        ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[process-substitution]=none
        ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
        ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[assign]=none
        ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
        ZSH_HIGHLIGHT_STYLES[named-fd]=none
        ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
        ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
        ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
    fi
else
    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%(#.#.$) '
fi
unset color_prompt force_color_prompt

toggle_oneline_prompt(){
    if [ "$PROMPT_ALTERNATIVE" = oneline ]; then
        PROMPT_ALTERNATIVE=twoline
    else
        PROMPT_ALTERNATIVE=oneline
    fi
    configure_prompt
    zle reset-prompt
}
zle -N toggle_oneline_prompt
bindkey ^P toggle_oneline_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
*)
    ;;
esac

precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
        if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
            _NEW_LINE_BEFORE_PROMPT=1
        else
            print ""
        fi
    fi
}

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

############################ PYTHON VIRTUAL ENVIRONMENT ##########################
# sudo apt install python3-venv
alias pipenv3='python3 -m pip'
alias pip3env='python3 -m pip'
alias pipenvpkglist='python3 -m pip list'
alias py3='python3'
alias py3.11='python3.11'
alias pyvenvinstall='python3 -m pip install'
# Créer un environnement virtuel à l'emplacement: /path/to/my/nom_de_mon_virtualenv
# python3 -m venv /path/to/my/nom_de_mon_virtualenv
alias createvenv='python3 -m venv'
alias makevirtualenv='python3 -m venv'
# ou utiliser virtualenv
#-------------------------------------- VIRTUAL ENV
# Fonction pour activer un environnement virtuel
activate_virtualenv() {
    local env_path="$1"
# source "$env_path/bin/activate"  # commented out by conda initialize
}

# Exemple d'utilisation : activate_virtualenv "/chemin/vers/nouvel/environnement"
alias pyvenvactivate=activate_virtualenv
alias activenv=activate_virtualenv
alias activevenv=activate_virtualenv
########################################## OTHER ALIASES
#alias laravel='/home/REPLACE-BY-YOUR-USERNAME/.config/composer/vendor/laravel/installer/bin/laravel'
#alias opencv_compile='function _compile_opencv() { g++ -o $1 $2 `pkg-config --cflags --libs opencv4`; }; _compile_opencv'
#alias opencv_compile2='g++ -o output $1 `pkg-config --cflags --libs opencv4`'
#alias ocv2='opencv_compile'

# Zydra password cracker
#alias zydra='python3 /home/REPLACE-BY-YOUR-USERNAME/.local/lib/python3.11/site-packages/zydra/zydra.py'
#alias "zydra -h"=='zydra --help'

## markdown to pdf
#alias md2pdf='grip'
#alias markdown2pdf='grip'

# ngrok
alias ngroktoken='/home/REPLACE-BY-YOUR-USERNAME/.var/app/ngrok config add-authtoken PLACE-YOUR-TOKEN-KEY-HERE'
alias ngrokcfg='ngroktoken'
alias ngrok='ngroktoken && /home/REPLACE-BY-YOUR-USERNAME/.var/app/ngrok'

####################################################################END VENV
# bun
# bun completions
#[ -s "/home/REPLACE-BY-YOUR-USERNAME/.bun/_bun" ] && source "/home/REPLACE-BY-YOUR-USERNAME/.bun/_bun"

# bun
#export BUN_INSTALL="$HOME/.bun"
#export PATH="$BUN_INSTALL/bin:$PATH"

########################################
# Mémoire RAM maximale autorisée sur un ordinateur (colorie en rouge la valeur et en bleu le nom). Faire expliquer le code par chatgpt.
myrammax() {
  sudo dmidecode | \
    awk '/Physical Memory Array/ {print "\033[36m" $0 "\033[0m"; next} /Maximum Capacity: 8 GB/ {print "\033[31m" $0 "\033[0m"; next} {print}'
}

# Add an alias to use the function easily
alias myram="myrammax"

# Function to display dmidecode results with specified color coding
colorize_dmidecode() {
    sudo dmidecode -t 16 | \
    awk '
        /Physical Memory Array/ {print "\033[0;32m" $0 "\033[0m"; next} 
        /Maximum Capacity: 8 GB/ {print "\033[0;31m" $0 "\033[0m"; next} 
        {print $0}
    '
}

# Alias to run the colorize_dmidecode function
alias colordmi='colorize_dmidecode'
alias myexactram="colorize_dmidecode"
alias myexactram="colorize_dmidecode"
alias myramsize="colorize_dmidecode"
########################################
# installing VM :  https://github.com/REPLACE-BY-YOUR-USERNAME-dev/Debian-12-stuffs/blob/main/installing-virtual-machine-kvm-qemu.md
#
# activate virsh network ===> sudo virsh net-start NETWORK_NAME_HERE
#alias virshnetw='sudo virsh net-start'

# activate the default virsh network ===> sudo virsh net-start default
#alias virshdefaultnetwork='sudo virsh net-start default'

# start the default virsh network on boot ===> sudo virsh net-autostart default
#alias virshnetw_onboot='sudo virsh net-autostart default'

# view all networks on virt-manager
#alias viewvirshall='sudo virsh net-list --all'
#alias virshnetlist='viewvirshall'
#alias vm='virt-manager'
########################################
#
# JAVA installation real path or directory with these commands 
# java -XshowSettings:properties -version OR which java or where java which will give in reality, a symlink
# this other give the real directory >>>> java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home' 

alias javadir='dirname $(dirname $(readlink -f $(which javac)))'

###################################################################################################################
# open vpn
#alias vpnactive='sudo openvpn /opt/vpnfiles/REPLACE-BY-YOUR-USERNAME.ovpn'
#alias ovpn='vpnactive'
#alias myvpn='vpnactive'

# switching user to superuser or root: sudo -i or sudo su or 
#alias susu='sudo su'

########################################
# 
# comment utiliser : rename_files_by_prefix /chemin/du/dossier "y2mate.com - "

# function rename_files_by_prefix() {
function renommertout() {
  local directory="$1"
  local string_to_remove="$2"

  if [ -d "$directory" ]; then
    cd "$directory"
    for file in *; do
      if [[ $file == "$string_to_remove"* ]]; then
        new_name="${file#$string_to_remove}"
        mv "$file" "$new_name"
        echo "Renommé : $file -> $new_name"
      fi
    done
    echo "Terminé."
  else
    echo "Le dossier $directory n'existe pas."
  fi
}

# renommer tous les fichiers du dossier spécifié : renamemyfiles dossier_spécifié "chaîne à supprimer"
alias renamemyfiles='renommertout'

# renommer tous les fichiers du dossier courant
alias renameallmyfiles='renommertout . "y2mate.com - "'

# ##########################################################################
# a function to add any directory to the Environment PATH
# by typing on the terminal ==>>    set_software_path /path/to/the/bin_directory

function set_software_path() {
    if [ -d "$1" ]; then
        export PATH="$1:$PATH"
        source ~/.zshrc # important for making changes be applied. Use .bashrc if you use bash instead of zsh.
        echo "$1 added successfully to the PATH."
    else
        echo "$1 directory not found at $1. Please check the installation path."
    fi
}

# opposite of set_software_path(). How to use it? ==>    removefrompath /path/to/remove/from/PATH

function removefrompath() {
    local path_to_remove="$1"
    local new_path=""
    local IFS=":"  # Set the Internal Field Separator to colon

    for directory in $PATH; do
        if [ "$directory" != "$path_to_remove" ]; then
            new_path="$new_path:$directory"
        fi
    done

    # Remove the leading colon and update the PATH
    export PATH="${new_path#:}"
    source ~/.zshrc # important for making changes be applied. Use .bashrc if you use bash instead of zsh.
    echo "$path_to_remove has been removed from your PATH successfully."
}


alias add_to_path='set_software_path'
alias addtopath='set_software_path'

# Quick shortcuts for my personal use
alias sourcezhrc='source ~/.zshrc'
alias sourcezshrc='source ~/.zshrc'
alias openzshrc='subl ~/.zshrc'


# Into my wine directory
#alias myWinedir='sudo -i sh -c "cd /root/.wine/drive_c && exec zsh"'
#alias intoMSWindir='myWinedir'
#alias myWine_x64dir='sudo -i sh -c "cd /root/.wine/drive_c/Program\ Files/ && exec zsh"'
#alias myWine_x86dir='sudo -i sh -c "cd /root/.wine/drive_c/Program\ Files\ (x86)/ && exec zsh"'

# laravel 
# already created with addtopath function but doesn't work after computer reboot
#alias laravel='~/.config/composer/vendor/bin/laravel'

# Java Swing examples set
#alias swingset2='java -jar /home/REPLACE-BY-YOUR-USERNAME/.java/swingset/SwingSet2.jar'
#alias swingset3='java -jar /home/REPLACE-BY-YOUR-USERNAME/.java/swingset/SwingSet3.jar'

# Maven
#alias mvn='/opt/apache-maven-3.9.5/bin/mvn'

# JAVA 17 HOME or Java Platform ---> java is always located at the "/usr/lib/jvm" path
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# JAVAFX 21.02
# Eclipse IDE configs ==> https://openjfx.io/openjfx-docs/
# https://openjfx.io/openjfx-docs/images/ide/eclipse/ide/eclipse08.png
export JAVAFX21_HOME=/home/REPLACE-BY-YOUR-USERNAME/.var/app/javafx-sdk-21.0.2/lib/
# VM ARGUMENTS ==> --module-path /home/REPLACE-BY-YOUR-USERNAME/.var/app/javafx-sdk-21.0.2/lib --add-modules javafx.controls,javafx.fxml,javafx.base,javafx.graphics,javafx.media,javafx.swing,javafx.web
# VM ARGUMENTS ==> --module-path ${JAVAFX_PATH} --add-modules javafx.controls,javafx.fxml,javafx.base,javafx.graphics,javafx.media,javafx.swing,javafx.web
####### ANACONDA 23 / 24

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/REPLACE-BY-YOUR-USERNAME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/REPLACE-BY-YOUR-USERNAME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/REPLACE-BY-YOUR-USERNAME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/REPLACE-BY-YOUR-USERNAME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# activate anaconda base environment on startup
# 
alias condabaseactive='conda config --set auto_activate_base true'
alias condabasedeactive='conda config --set auto_activate_base false'

# If you simply need to disable the Anaconda base environment, use :  
alias condadesactive='conda deactivate'
# If you simply need to enable the Anaconda base environment, use :  
alias condactiv='conda activate'

# Launch anaconda in web browser
alias webconda='anaconda-navigator'

# for other stuffs, conda --help

alias notebook='jupyter notebook'

################  CVE-MAKER  #################
# 
# CVE, Common Vulnerabilities and Exposures en anglais, désigne une liste publique de failles de sécurité informatique
# cve-maler IS A tool to find CVEs and Exploits. Can be used as Exploits creator 
# https://github.com/msd0pe-1/cve-maker
# https://cve.mitre.org/
#alias cvemaker='python3 -m cve-maker'

############### gtk4 ################
#
# Without specifying output name (default output name will still be the given name to your program source)
# compile_gtk testgtk4.c   # --> this will compile "testgtk4.c" into an executable named "testgtk4"
#
# Specify output name
# compile_gtk testgtk4.c myprogram   # --> this will compile "testgtk4.c" into an executable named "myprogram"

compile_gtk() {
    if [ "$#" -lt 1 ]; then
        echo "Usage: compile_gtk <source_file> [output_name]"
        return 1
    fi
    
    local source_file="$1"
    local output_name="${2:-${source_file%.*}}"
    
    gcc "$source_file" -o "$output_name" $(pkg-config --cflags --libs gtk4)
}

alias compile_gtk4='compile_gtk'
alias compilegtk4='compile_gtk'
alias gcc_gtk4='compile_gtk'
alias gccgtk4='compile_gtk'
alias 'gcc gtk4'='compile_gtk'
alias gcc-gtk4='compile_gtk'

###

# To play a video using VLC from the terminal in nohup mode
play_video() {
    video_path="$1"

    if [ -f "$video_path" ]; then
        nohup vlc "$video_path" &
        echo "Playing video in the background. Check nohup.out for logs."
    else
        echo "Error: The specified file does not exist."
    fi
}

# Call the function
alias openvideo='play_video'
alias readvid='play_video'

#########
