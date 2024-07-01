###############################################################################
#                              ZSH CURSOR CONFIG                              #
###############################################################################
# Change cursor according to the keymap (vi=block emacs=beam)
# See: https://github.com/romkatv/powerlevel10k/issues/687#issue-611570574
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne '\e[2 q'
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
        echo -ne '\e[6 q'
    fi
}
zle -N zle-keymap-select

# Use beam shape cursor for each new prompt.
preexec() {
	echo -ne '\e[6 q'
}

_fix_cursor() {
	echo -ne '\e[6 q'
}
precmd_functions+=(_fix_cursor)

zle -N zle-keymap-select
