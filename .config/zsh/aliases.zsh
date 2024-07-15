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
# Set specific BAT theme for batman
# alias man='BAT_THEME=1337 batman'

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

# Read the config file
EZA_FLAGS=$(cat $HOME/.config/eza/eza-flags.conf)
# Replace ls with eza. Requires 'eza'
alias ls="eza $EZA_FLAGS"
# Some quick file/directory listing commands
# Detailed list view
alias   ll="eza $EZA_FLAGS -l "                 # Detailed list default
alias   la="eza $EZA_FLAGS -la "                # All (inc hidden)
alias  lls="eza $EZA_FLAGS -l --sort=size "     # Size-sorted
alias  lln="eza $EZA_FLAGS -la --sort=newest "  # Date-sorted
alias  lld="eza $EZA_FLAGS -lD "                # Directories only
alias  llf="eza $EZA_FLAGS -lf "                # Files only
alias  las="eza $EZA_FLAGS -la --sort=size "    # All, Size-sorted
alias  lan="eza $EZA_FLAGS -la --sort=newest "  # All, Date-sorted
alias  lad="eza $EZA_FLAGS -laD "               # All, Directories only
alias  laf="eza $EZA_FLAGS -laf "               # All, Files only
# Tree view
alias tree="eza $EZA_FLAGS --tree"

# Make executable
alias mkexe='chmod +x '

# rsync - Copy/move with info & progress
alias rscp='rsync -avrh --info=progress2'
alias rsmv='rsync -avrh --info=progress2 --remove-source-files'

# ---- GIT --------------------------------------------------------------------
# Dotfiles management alias. Uses ~/.dot as bare repo with ~ as work tree.
alias dot="/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME"

# ---- Process Management------------------------------------------------------
# List all processes with highly verbose output
alias psv='ps axfo pid,euser,egroup,args'

# ---- System -----------------------------------------------------------------
# Launch a shell with the zprof profiler
alias zprofile='time ZSH_DEBUGRC=1 zsh -i -c exit'

# Pretty print the path
alias ppath='echo $PATH | tr -s ":" "\n"'

# Font search. See also 'fontpreview' and 'gtk2fontsel'
alias fs-family='fc-list : family | grep -i '
alias fs-file='fc-list : file | grep -i '
alias fs-match='fc-match '

# Graphical sudo
alias gsu='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'

# Copy current working dir path to clipboard
alias cwd="pwd | tr -d '\n' | tr -d '\r' | wl-copy"

# ---- Other ------------------------------------------------------------------
# Translator (requires https://github.com/soimort/translate-shell)
alias to-pt='trans :pt-PT'
alias to-en='trans :en'
alias speak='trans -sp'

# icat - Kitty image image viewer
alias icat='kitty +kitten icat'

# Football schedule
alias foot='python $HOME/Scripts/football.py  -d5 -e 15 -t'
