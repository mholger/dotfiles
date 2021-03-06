#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

if [ -f ~/.bashedrc ]; then
    . ~/.bashedrc
fi

if [ -x ~/qmk_utils/activate_wsl.sh ]
then
    source ~/qmk_utils/activate_wsl.sh
fi
