## FZF ##
# Custom FZF Shortcuts:
# 	Ctrl + T - Find any files/folders in $HOME
# 	Alt + C - Change to any directory in $HOME
export FZF_DEFAULT_COMMAND="fd"
export FZF_CTRL_T_COMMAND="fd . $HOME"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_DEFAULT_OPTS="
-i
--ansi
--border=horizontal
--border-label-pos=top
--color=16
--color=border:7
--color=marker:green
--color=prompt:yellow
--color=current-bg:237
--layout=reverse
--header-first
--info=inline-right
--height=90%
--margin=0%
--preview=''
--prompt='󱎸  '
--pointer='󰁚 '
--marker='󰄵 '
--bind='?:toggle-preview'
--bind='ctrl-a:select-all'
--bind='ctrl-e:execute(nvim {+} >/dev/tty)'
--bind='ctrl-u:preview-page-up'
--bind='ctrl-d:preview-page-down'"
# Additional opts:
# --marker='󰄵 '
# --border-label="┨  Label  ┠"
# --preview-window=':hidden'

export FZF_CTRL_R_OPTS=""
export FZF_ALT_C_OPTS="--preview='lsd --icon=always --color=always --tree --depth 1 {}'"
export FZF_CTRL_T_OPTS="--preview='$HOME/.config/fzf/preview.sh {}'"

# FZF with directory/file previewer for multiple mime-types
alias fzp="fzf --preview='$HOME/.config/fzf/preview.sh {}'"

## FUNCTIONS ##
# Edit a config file selected via FZF
cfile() {
  edfile=""
  if (( $# > 0 ))
	then
    edfile=$(find ~/.config -type f | fzf -q "$@" --preview='$HOME/.config/fzf/preview.sh {}')
  else
    edfile=$(find ~/.config -type f | fzf --preview='$HOME/.config/fzf/preview.sh {}')
  fi

  if [ -f $edfile ] && [[ $edfile != "" ]] ; then
    nvim $edfile
  fi
}

# CD to a config folder selected via FZF
cdir() {
  cddir=""
  if (( $# > 0 ))
	then
    cddir=$(find ~/.config -maxdepth 1 -type d | fzf -q "$@" --preview='lsd --tree --icon=always --color=always --depth 2 {}')
  else
    cddir=$(find ~/.config -maxdepth 1 -type d | fzf --preview='lsd --tree --icon=always --color=always --depth 2 {}')
  fi

  if [ -d $cddir ] && [[ $cddir != "" ]] ; then
    cd $cddir
  fi
}
