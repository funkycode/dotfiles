bindkey -e

# --// Load zsh modules \\--

autoload -Uz compinit zcalc zsh-mime-setup colors
compinit
autoload -U promptinit
promptinit

# --// Options \\--

setopt PUSHD_MINUS
setopt NO_HUP
setopt NO_BEEP
setopt NO_CASE_GLOB
setopt IGNORE_EOF
setopt ALL_EXPORT
setopt notify pushdtohome cdablevars autolist
setopt recexact longlistjobs
setopt autoresume histignoredups pushdsilent
setopt autopushd pushdminus
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt autocd
setopt extendedglob
#setopt correctall
#setopt correct
unsetopt bgnice autoparamslash
#unsetopt ALL_EXPORT

# --// Autoload zsh modules when they are referenced \\--

zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfile

# --// Completions \\--

#zstyle ':completion:*' completer _complete _ignored _match _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
#zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for:%b %d'
export EDITOR="/usr/bin/vim" \
BROWSER="/usr/bin/luakit" \
PAGER="/usr/bin/vimpager" \
       MANPAGER="/usr/bin/vimpager" \
LC="en_US.UTF-8" \
LC_ALL="en_US.UTF-8"

# --// TMUX \\--

[ "$TERM" = screen ] && export TERM=screen-256color

#if [[ -z "$TMUX" ]]; then
# tmux
#fi

# --// Custom Prompt \\--

local curdir="%d"
local hostname="%M"
local username="%n"
local bold="%B"
local unbold="%b"
local standout="%S"
local unstandout="%s"
local colorfg="%F"
local uncolorfg="%f"
local colorbg="%K"
local uncolorbg="%k"
local mytime="%*"
local mydate="%D"
local line_tty="%y"
local rootorwhat="%#"
local return_status="%?"

#export ps1=$'%F{black}%B┌%K{black}%F{blue}%B %n %b%f%k%K{black}·%F{red} %T %f%k%K{black}·%F{green} %y %f%k%K{black}·%F{yellow}%B %~ %b%f%k
#%F{black}%B└%{\e[40;1;37m%} %% %{\e[0m%}%F{black}%B¬%b%f '
#export PS2=$'%{\e[1;33m%} %_>%{\e[0m%} '

#export PS1=$'%B┌%b[%B%n%b~%d]
#%B└%b[%#]%B¬%b '
#export PS2=$'%{\e[1;33m%} %_>%{\e[0m%} '

#PROMPT=" %F{yellow}%B%n%b%f %F{red}|%f %F{blue}%*%f %F{red}|%f %F{green}${PWD/#$HOME/~}%f
# %F{red}%(!.● .● )%f% %F{blue}%(!.● .● )%f% %F{green}%(!.● .● )%f%"
#RPROMPT="%F{yellow}%*%f"

PROMPT=" %F{blue}%(!.>.>)%f% %F{blue}%(!.> .> )%f%"

#PROMPT="┌─────── %F{black}%B%n%b%f | %M% | %B${PWD/#$HOME/~}%b
#└─>%(!.#.>> )%"
#RPROMPT="%B%*%b"

#PROMPT="$colorfg{blue}$uncolorfg$bold$curdir$unbold$colorfg{blue}$uncolorfg
#$username$bold$colorfg{red}:${uncolorfg}$unbold$hostname $colorfg{yellow}»$uncolorfg "

# --// Color Support \\--

eval "`dircolors -b $HOME/.LS_COLORS`"
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
export LS_COLORS
export PATH=/usr/share/perl5/vendor_perl/auto/share/dist/Cope:$PATH

# --// Aliases \\--
alias update='sudo aptitude update'
alias upgrade="sudo aptitude upgrade"
alias install='sudo aptitude install'
alias remove='sudo aptitude remove'
alias search='aptitude search'

alias pacman-colors='~/bin/pacman'
alias info='~/bin/info'

alias mount-iso='sudo mount -o loop'

# --// Pipes \\--

alias -g G='| grep'
alias -g S='| sort'
alias -g L='| less'
alias -g T='| tail'
alias -g H='| head'
alias -g DN='/dev/null'
alias -g NULL='> /dev/null 2>&1'

# --// Update Clock \\--

update-clock () {
sudo ntpdate -s time.ien.it
sudo hwclock -w
}

# --// Cleanup \\--

cleanup () {
    echo -e "-->> Cleaning Thumbnails <<--"
# sudo /bin/rm -rfv ~/.thumbnails/*
    sudo /bin/rm -rfv /root/.thumbnails/*
    echo "-->> Removing Flash Player cache <<--"
    sudo /bin/rm -rfv ~/.adobe/*
    sudo /bin/rm -rfv /root/.adobe/*
    sudo /bin/rm -rfv ~/.macromedia/*
    sudo /bin/rm -rfv /root/.macromedia/*
    sudo /bin/rm -rfv ~/.cacaoweb/*.cacao
    echo "-->> Cleaning Cache <<--"
    sudo /bin/rm -rfv ~/.motion/files/*.jpg
    sudo /bin/rm -rfv ~/.cache/*
    sudo /bin/rm -rfv /root/.cache/*
    sudo /bin/rm -rfv ~/.lyrics/*
    echo "-->> Cleaning Trash <<--"
    sudo /bin/rm -rfv ~/.local/share/Trash/*
    sudo /bin/rm -rfv /root/.local/share/Trash/*
    #sudo /bin/rm -rfv /tmp/*
    sudo /bin/rm -rfv /home/.Trash-0/*
    sudo /bin/rm -rfv /media/Windows/*.Bin/*
    sudo /bin/rm -rfv /media/Windows/System*/*
    sudo /bin/rm -rfv /media/Data/*.Bin/*
    sudo /bin/rm -rfv /media/Data/System*/*
    echo
}

# --// Creates an archive from given directory \\--

mktar() { tar cvf "${1%%/}.tar" "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz" "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# --// Extract archives \\--

extract () {
     if [ -f $1 ] ; then
case $1 in
             *.tar.bz2) tar xjf $1 ;;
             *.tar.gz) tar xzf $1 ;;
             *.bz2) bunzip2 $1 ;;
             *.rar) unrar x $1 ;;
             *.gz) gunzip $1 ;;
             *.tar) tar xf $1 ;;
             *.tbz2) tar xjf $1 ;;
             *.tgz) tar xzf $1 ;;
             *.zip) unzip $1 ;;
             *.Z) uncompress $1 ;;
             *.7z) 7z x $1 ;;
             *) echo "'$1' cannot be extracted via extract()" ;;
         esac
else
echo "'$1' is not a valid file"
     fi
}

# --// History \\--

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt EXTENDED_HISTORY # puts timestamps in the history
setopt HIST_VERIFY # when using ! cmds, confirm first
setopt HIST_IGNORE_DUPS # ignore same commands run twice+
setopt APPEND_HISTORY # don't overwrite history
setopt SHARE_HISTORY # _all_ zsh sessions share the same history files
setopt INC_APPEND_HISTORY # write after each command

# --// Presentation \\--

color-block () {
echo
width=$(( (`tput cols` / 16) -1 ))
chars=""
prespaces=$(( (`tput cols`-($width+1)*16)/2 ))
for i in `seq $width`; chars="${chars}|"
for i in `seq $prespaces`; echo -n " "
for i in `seq 0 7`; echo -en "\e[3${i}m${chars} \e[1;3${i}m${chars}\e[m "; echo; echo
unset width
unset chars
unset prespaces
}

color-blocks () {
    echo
local width=$(( ($COLUMNS / 16) -1 ))
    local chars
    local pre=$(( ( $COLUMNS - ($width+1)*16)/2 ))
    for ((i=0; i<$width; i++)); chars+="\u2591"
    for ((i=0; i<$pre; i++)); echo -n " "
    for ((i=0; i<=7; i++)); echo -en "\e[3${i}m${chars} \e[1;3${i}m${chars}\e[m "; echo; echo
unset i
}

# --// Vim font \\--

#vim_font() {
# echo -e '\e]710;xft:Pragmata:pixelsize=13:antialias=true:hinting=true\007' # New Font
# vim $*
# echo -e '\e]710;xft:Tamsyn-tt:pixelsize=13:antialias=true:hinting=true\007' # Old Font
#}
#alias vim='vim_font'
