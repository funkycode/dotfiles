### zsh configuration file by vladislavbyk ###

### Load zsh modules ###
autoload -Uz compinit zcalc zsh-mime-setup colors
compinit
autoload -U promptinit
promptinit

### Options ###
export DEBEMAIL=vladislabyk1@gmail.com #---change this to your email if you need this---
bindkey -e
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
unsetopt bgnice autoparamslash

### Autoload zsh modules when they are referenced ###
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof

### Completions ###
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
LC="ru_RU.UTF-8" \
LC_ALL="ru_RU.UTF-8"

### Custom Prompt ###
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

# Prompt default:
# >>
PROMPT=" %F{blue}%(!.>.>)%f% %F{blue}%(!.> .> )%f%"

### Color Support ###
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

### Aliases ###
#Aptitude
alias update='sudo aptitude update'
alias upgrade="sudo aptitude upgrade"
alias install='sudo aptitude install'
alias remove='sudo aptitude remove'
alias purge='sudo aptitude purge'
alias search='aptitude search'
alias show='aptitude show'
#Other
alias mount-iso='sudo mount -o loop'
alias SCRIPTS='echo "Available scripts in zshrc:\nupdate-clock; cleanup; myip; extract; mktar; mktgz; mktbz.\nAvailable aliases in zshrc:\nupdate; upgrade; install; remove; purge; show; search; mount-iso."'

### Update Clock ###
update-clock () {
sudo ntpdate -s time.ien.it
sudo hwclock -w
}

### Cleanup ###
cleanup () {
    echo -e "--Cleaning Thumbnails"
    sudo /bin/rm -rfv /root/.thumbnails/*
    echo "--Removing Flash Player cache"
    sudo /bin/rm -rfv ~/.adobe/*
    sudo /bin/rm -rfv /root/.adobe/*
    sudo /bin/rm -rfv ~/.macromedia/*
    sudo /bin/rm -rfv /root/.macromedia/*
    sudo /bin/rm -rfv ~/.cacaoweb/*.cacao
    echo "--Cleaning Cache"
    sudo /bin/rm -rfv ~/.motion/files/*.jpg
    sudo /bin/rm -rfv ~/.cache/*
    sudo /bin/rm -rfv /root/.cache/*
    sudo /bin/rm -rfv ~/.lyrics/*
    echo "--Cleaning Trash"
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

### Creates an archive from given directory ###
mktar() { tar cvf "${1%%/}.tar" "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz" "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

### Extract archives ###
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

### IP ###
myip() {lynx --source http://www.formyip.com/ |grep The | awk {'print $5'}}

### Tmux ###
alias tmux="tmux -2 -u"
if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach -t work || ~/bin/tmux_work.sh; exit
fi

### History ###
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt HIST_IGNORE_DUPS
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
