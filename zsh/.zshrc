#
# /etc/zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#

##
## set term to 256 color mode 
##

[[ xterm == xterm ]] && export TERM=screen-256color

##
## auto Complete
##

autoload -Uz compinit promptinit 
compinit
promptinit

##
## skip /etc/zsh/zshrc compinit function
##

skip_global_compinit=1

##
## completion
##

zstyle ':completion:*' completer _expand _complete _ignored                                  
zstyle ':completion:*' group-name ''                                                         
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s' 
zstyle ':completion:*' max-errors 1                                                          
zstyle ':completion:*' menu select=long-list select=0                                        
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'         
zstyle ':completion:*' use-compctl false                                                     
zstyle ':completion:*' verbose true                                                          
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#zstyle  :compinstall filename '/root/.zsh/.zshrc'   #dont know wtf


##
## completion colors
##

## template

#zstyle ':completion:*' list-colors '=*=' 


zstyle ':completion:*' list-colors '=*=0;34;40' #blue    #${(s.:.)LS_COLORS}                                                        

#zstyle ':completion:*' list-colors '=(#b) #([0-9]#)*( *[a-z])*=34=31=33'                                                       
#zstyle ':completion:*:*:kill:*' list-colors '=(#b) #([0-9]#)*( *[a-z])*=34=31=33' 

zstyle ':completion:*:options' list-colors '=^(-- *)=34' #blue
zstyle ':completion:*:commands' list-colors '=*=1;36;40' #cyan                                                
zstyle ':completion:*:aliases' list-colors '=*=1;35;40' #magenta

##
## set prompts
##

autoload -U colors && colors
PROMPT="%{$fg[green]%}%n@%m%{$reset_color%}: %{$fg[blue]%}%1~ %{$reset_color%}%# "

#PROMPT='[%n@%m]%~%# '    # default prompt
#RPROMPT=' %~'            # prompt for right side of screen

##
## highlight
##

source ~/.zsh/zsh-syntax-highlighting.zsh
#ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main pattern brackets)

## root
#ZSH_HIGHLIGHT_STYLES[root]='bg=red'

## brackets
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=white'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta'

## cursor
ZSH_HIGHLIGHT_STYLES[cursor]='bg=blue'

## main

## default
ZSH_HIGHLIGHT_STYLES[default]='cyan'                                 # default color 

## unknown
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'                         # unknown command

## command
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta'                     # зарезервированное слово
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta'                             # alias
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'                             # built-in function (example: echo)
ZSH_HIGHLIGHT_STYLES[function]='fg=green'                            # shell-assigned function
ZSH_HIGHLIGHT_STYLES[command]='fg=cyan'                              # standart command
ZSH_HIGHLIGHT_STYLES[precommand]='fg=red'                            # pre-command (example: sudo)
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=cyan'                     #  && || ;
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'                      # команда, найденная в путях (hashed)
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=blue'                 # флаги типа -*
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=blue'                 # флаги типа --*

## path
ZSH_HIGHLIGHT_STYLES[path]='fg=blue'                                 # path
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=blue'                          # path prefix
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=blue'                          # примерный путь

## shell
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue'                             # template (example: /dev/sda*)
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=green'                   # history (!command)
ZSH_HIGHLIGHT_STYLES[assign]='fg=magenta'                            # присвоение
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=grey'        # "$VARIABLE"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=grey'          # \"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=magenta'              # `command`

## quotes
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=white'              # 'text' form
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=white'              # "text" form

## DANGER pattern

#ZSH_HIGHLIGHT_PATTERNS+=('rm *' 'fg=white,bold,bg=red')             # DANGER 

ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=red')         # DANGER 
ZSH_HIGHLIGHT_PATTERNS+=('rm *' 'fg=red')             # DANGER 
ZSH_HIGHLIGHT_PATTERNS+=('kill *' 'fg=red')           # DANGER 
ZSH_HIGHLIGHT_PATTERNS+=('killall *' 'fg=red')        # DANGER 

##
## shell functions
##

#setenv() { export $1=$2 }  # csh compatibility

##
## input correction
##

setopt CORRECT_ALL

##
## no-cd-command
##

setopt autocd

##
## history
##

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=99999

##
## from new-user-install
##

setopt appendhistory extendedglob nomatch notify
unsetopt beep

##
## alias
##

alias -g df='df -h'
alias -g c='clear'
alias -g ll='ls -alG'
alias -g g=' |grep'
alias -g ls='ls -G'
alias -g nount='mount |column -t'

##
## key bindings
##

#bindkey -v               # vi key bindings
#bindkey -e               # emacs key bindings

bindkey ' ' magic-space  # also do history expansion on space

_src_etc_profile_d()
{
    ##  Make the *.sh things happier, and have possible ~/.zshenv options like
    ##  NOMATCH ignored.
    emulate -L ksh


    ## from bashrc, with zsh fixes
    if [[ ! -o login ]]; then # We're not a login shell
        for i in /etc/profile.d/*.sh; do
	    if [ -r "$i" ]; then
	        . $i
	    fi
        done
        unset i
    fi
}
_src_etc_profile_d

unset -f _src_etc_profile_d
