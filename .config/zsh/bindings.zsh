###############################################################################
#                               ZLE KEY BINDINGS                              #
###############################################################################
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Note:
# Ctrl+R, Ctrl+T, Alt+C are set in fzf.zsh

# ---- Main mode --------------------------------------------------------------
# Use emacs key bindings, but remap the ESC key to enter vi command mode.
bindkey -e

# ---- Custom Keys ------------------------------------------------------------
bindkey '^[' vi-cmd-mode # [ESC] - Enter vi command mode (^[ = \e)

bindkey '^[^M' self-insert-unmeta # [Alt+Return] - Line break

bindkey "^[[5~" up-line-or-history   # [PageUp] - Up a line of history
bindkey "^[[6~" down-line-or-history # [PageDown] - Down a line of history

autoload -U up-line-or-beginning-search && zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search && zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search   # Start typing + [Up] - Previous command in history matching buffer text
bindkey "^[[B" down-line-or-beginning-search # Start typing + [Down] - Next command in history matching buffer text
bindkey "^[[Z" reverse-menu-complete         # [Shift-Tab] - Move backwards through the completion menu

bindkey "^[[H" beginning-of-line # [Home] - Go to beginning of line
bindkey "^[[F" end-of-line       # [End] - Go to end of line
bindkey '^[[1;5C' forward-word   # [Ctrl-RightArrow] - Move forward one word
bindkey '^[[1;5D' backward-word  # [Ctrl-LeftArrow] - Move backward one word

bindkey "^[[3~" delete-char # [Delete] - Delete char
bindkey '^[[3;5~' kill-word # [Ctrl-Delete] - Delete whole forward-word
bindkey '^[w' kill-region   # [Esc-w] - Kill from the cursor to the mark

autoload -U edit-command-line && zle -N edit-command-line
# Edit the current command line in $EDITOR
bindkey '\C-x\C-e' edit-command-line
bindkey '^[e' edit-command-line

# Go to previous directory
cdUndoKey() {
  popd
  zle reset-prompt
  print
  ls
  zle reset-prompt
}
zle -N cdParentKey # Define widget

# Go to parent directory
cdParentKey() {
  pushd ..
  zle reset-prompt
  print
  ls
  zle reset-prompt
}
zle -N cdUndoKey # Define widget

bindkey '^[[1;3A' cdParentKey # [Alt+Up] - Cd to the parent directory
bindkey '^[[1;3D' cdUndoKey   # [Alt+Left] - Cd to the previous directory
