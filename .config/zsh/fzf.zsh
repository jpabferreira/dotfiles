###############################################################################
#                                  FZF CONFIG                                 #
###############################################################################
# ---- Environment Variables --------------------------------------------------
# Default command for FZF
export FZF_DEFAULT_COMMAND="fd"

# Find home files/directories with Ctrl+T
export FZF_CTRL_T_COMMAND="fd . $HOME"
# Ctrl+T options
export FZF_CTRL_T_OPTS="--preview='$HOME/.config/fzf/preview.sh {}'"

# Find home directories with Alt+C
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
# Alt+C options
export FZF_ALT_C_OPTS="--preview='lsd --icon=always --color=always --tree --depth 1 {}'"

# Ctrl+R (history search) options
export FZF_CTRL_R_OPTS=""

# Default FZF Config
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

# ---- Aliases-----------------------------------------------------------------
# Kill user process with FZF
alias fzfkill="ps -au joao | awk '{printf \"%7.7s   %-15s \n\" , \$1, \$4}' | fzf --header-lines=1 --no-preview -i --border-label=' 󰯈  TERMINATE PROCESS 󰯈 ' --margin=1,1% | awk '{printf \$1}' | xargs kill -9"

# ---- Functions --------------------------------------------------------------
# Open file selected via FZF with directory/file previewer for multiple mime-types
fzfopen() {
  selfile=$(fzf --preview='$HOME/.config/fzf/preview.sh {}')
  if [[ -f "$selfile" ]]; then
    xdg-open "$selfile" & disown
  fi
}

# cfile - Select a config file for edition with FZF
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

# cdir - Change to a config directory selected with FZF
cdir() {
  cddir=""
  if (( $# == 0 ))
	then
    cddir=$(find ~/.config -maxdepth 1 -type d | fzf --preview='lsd --tree --icon=always --color=always --depth 2 {}')
  else
    if [[ -d "$HOME/.config/$1" ]]
    then
      cddir="$HOME/.config/$1"
    else
      cddir=$(find ~/.config -maxdepth 1 -type d | fzf -q "$@" --preview='lsd --tree --icon=always --color=always --depth 2 {}')
    fi
  fi

  if [ -d $cddir ] && [[ $cddir != "" ]] ; then
    cd "$cddir"
  fi
}
