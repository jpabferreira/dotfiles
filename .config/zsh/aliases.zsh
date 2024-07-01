###############################################################################
#                                 ZSH ALIASES                                 #
###############################################################################
# ---- COLORIZE OUTPUT & OVERRIDE APPLICATIONS --------------------------------
# Replace diff with batdiff
alias diff='batdiff --delta'
# Colorize grep output
alias grep="grep --color=always"
# Colorize ip output
alias ip='ip -color=always'
# Replace man with batman to read man pages. Requires bat-extras
alias man='batman'

# ---- QUICK ACCESS -----------------------------------------------------------
# Temporary notes
alias notes="nvim $HOME/Documents/Notes/TmpNotes"
# System setup notes
alias setup="nvim $HOME/Documents/PersonalNotes/setup-base-system"
# Zsh config files
alias zali="nvim $HOME/.config/zsh/aliases.zsh"
alias zfun="nvim $HOME/.config/zsh/functions.zsh"
alias zexp="nvim $HOME/.config/zsh/exports.zsh"
alias zopt="nvim $HOME/.config/zsh/options.zsh"
alias zplu="nvim $HOME/.config/zsh/plugins.zsh"
alias zbin="nvim $HOME/.config/zsh/bindings.zsh"
alias zfix="nvim $HOME/.config/zsh/fixes.zsh"

# ---- Filesystem-related -----------------------------------------------------
# Quick dir change (fav locations)
alias cdown="cd $HOME/Downloads"
alias cdocs="cd $HOME/Documents"
alias cmusi="cd $HOME/Music"    
alias cpics="cd $HOME/Pictures" 
alias crepo="cd $HOME/Repos"    
alias cscri="cd $HOME/Scripts"  

# Replace ls with lsd. Requires 'lsd'
alias ls='lsd --icon=always --color=always --group-directories-first --hyperlink=always'

# ls/lsd quick commands
alias lsa='ls -lah' 
alias l='ls -lah' # Detailed list, all, human-readable form
alias ll='ls -lh'  # Detailed list, human-readable form
alias la='ls -lAh' # Detailed list, all but hidden, human-readable form
alias ll-size='ls -lhSr' # Size-sorted
alias ll-date='ls -lhtr --date +"%d/%m/%Y %H:%M"' # Date-sorted
alias ll-dir='ls -lh | awk -e "/30md/ {print}" '  # Directories only
alias ll-file='ls -lh | awk -e "!/30md/ {print}" ' # Files only
alias tree='ls --tree' # Tree view

# Make executable
alias mkexe='chmod +x '

# rsync - Copy/move with info & progress
alias rscp='rsync -avrh --info=progress2'
alias rsmv='rsync -avrh --info=progress2 --remove-source-files'

# Find largest directories (TODO: substitute * for desired path)
alias big='du -ah * | sort -rh | head -20'

# ---- GIT --------------------------------------------------------------------
# Dotfiles management alias. Uses ~/.dot as bare repo with ~ as work tree.
alias dot="/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME"

# ---- Process Management------------------------------------------------------
# ps with highly verbose output
alias psv='ps axfo pid,euser,egroup,args'
# Kill process with FZF
alias pskill='ps -au joao | awk "{printf \"%7.7s   %-15s \n\" , \$1, \$4}" | fzf --header-lines=1 --no-preview -i --border-label=" 󰯈  TERMINATE PROCESS 󰯈 " --margin=1,1% | awk "{print \$1}" | xargs kill -9'
# Search running process. Return PID
alias psearch='ps -au joao | awk "{printf \"%7.7s   %-15s \n\" , \$1, \$4}" | grep -i '

# ---- System -----------------------------------------------------------------
# Launch a shell with the zprof profiler
alias zprofile='time ZSH_DEBUGRC=1 zsh -i -c exit'

# Pretty print the path
alias pathpr='echo $PATH | tr -s ":" "\n"'

# Font search. See also 'fontpreview' and 'gtk2fontsel'
alias fs-family='fc-list : family | grep -i '
alias fs-file='fc-list : file | grep -i '
alias fs-match='fc-match '

# Graphical sudo
alias xsudo='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'

# Clipboard
alias clip="xclip -selection c"
# Copy current working dir path to clipboard
alias pwdc="pwd | tr -d '\n' | tr -d '\r' | xclip -selection c"

# ---- Other ------------------------------------------------------------------
# Translator (requires https://github.com/soimort/translate-shell)
alias to-pt='trans :pt-PT'
alias to-en='trans :en'
alias speak='trans -sp'

# icat - Kitty image image viewer
alias icat='kitty +kitten icat'

# Football schedule
alias foot='python $HOME/Scripts/football.py  -d5 -e 15 -t'
