
# /__  / / ___// / / /  /   |  / (_)___ _________  _____
#   / /  \__ \/ /_/ /  / /| | / / / __ `/ ___/ _ \/ ___/
#  / /_____/ / __  /  / ___ |/ / / /_/ (__  )  __(__  ) 
# /____/____/_/ /_/  /_/  |_/_/_/\__,_/____/\___/____/ 
#
################################
#  /\  _  _ |. _ _ |_. _  _  _ #
# /--\|_)|_)||(_(_||_|(_)| )_) #
#     |  |                     #
################################
#
## Colorize output ##
alias diff='batdiff --delta'
alias grep="grep --color=always"
alias ip='ip -color=always'
#
## bat ##
# Set pager options for bat so that the output is maintained after closing
# alias bat='bat --pager="less -XF"'
# alias bat='bat --theme=OneHalfDark --paging=never'
alias bat='bat --theme=OneHalfDark'
#
## bat-extras ##
# Read manpages with batman
alias man='batman'
#
## rsync ## Copy/move based on verbose rsync with progress %
alias rscp='rsync -avrh --info=progress2'
alias rsmv='rsync -avrh --info=progress2 --remove-source-files'
#
## advcp / advmv ## Patched coreutils to support cp and mv with progress bar (-g option)
# See https://www.linuxfordevices.com/tutorials/linux/add-progress-bar-advanced-copy
# alias cp='/usr/local/bin/advcp -g'
# alias mv='/usr/local/bin/advmv -g'
#
alias md='mkdir -p'
alias rd=rmdir
## lsd ## Replacement for ls. Requires 'lsd':
alias ls='lsd --icon=always --color=always --group-directories-first --hyperlink=always'
# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias ll-size='ls -lhSr'
alias ll-date='ls -lhtr --date +"%d/%m/%Y %H:%M"'
alias ll-dir='ls -lh | awk -e "/30md/ {print}" '
alias ll-file='ls -lh | awk -e "!/30md/ {print}" '
alias tree='ls --tree'
#
## cdp (print) - ls after cd ##
cdp() { cd "$@" && ls; }
#
## ps ##
# Run ps with _verbose_ output
alias psv='ps axfo pid,euser,egroup,args'
# Search process
alias pss='ps -e | grep -i'
# Kill process with FZF
alias pskill='ps -au joao | awk "{printf \"%7.7s   %-15s \n\" , \$1, \$4}" | fzf --header-lines=1 --no-preview -i --border-label=" 󰯈  TERMINATE PROCESS 󰯈 " --margin=1,1% | awk "{print \$1}" | xargs kill -9'
# Search running process. Return PID
alias psearch='ps -au joao | awk "{printf \"%7.7s   %-15s \n\" , \$1, \$4}" | grep -i '
#
# Python & Pip
# alias python='$HOME/.venv/bin/python'
# alias python3='$HOME/.venv/bin/python3'
# alias pip='$HOME/.venv/bin/pip'
# alias pip3='$HOME/.venv/bin/pip3'
#
# Largest directories in any path (TODO: substitute * for desired path)
alias big='du -ah * | sort -rh | head -20'
alias sz='du -sh '
#
# Translator (requires https://github.com/soimort/translate-shell)
alias to-pt='trans :pt-PT'
alias to-en='trans :en'
alias speak='trans -sp'
#
# Football schedule
alias foot='python $HOME/Scripts/football.py  -d5 -e 15 -t'
alias bola='python $HOME/Scripts/football.py  -d5 -e 15 -t'
#
# Clipboard
alias clip="xclip -selection c"
# Copy current working dir path to clipboard
alias pwdc="pwd | tr -d '\n' | tr -d '\r' | xclip -selection c"
# Ncmpcpp with Cava
alias ncmp="kitty @ launch --title Cava --keep-focus cava && ncmpcpp"
#
##################
#  __            #
# (_    _|_ _ _  #
# __)\/_)|_(-||| #
#    /           #
##################
#
alias mkexe='chmod +x '
#
## Graphical sudo ##
alias xsudo='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'
#
## Font search ##
# See also 'fontpreview' and gtk2fontsel
alias fs-family='fc-list : family | grep -i '
alias fs-file='fc-list : file | grep -i '
alias fs-match='fc-match '
# alias font-paths+'grep /fonts /var/log/Xorg.0.log'
#
## Keyboard ##
alias layouts='bat /usr/share/X11/xkb/rules/base.lst'
alias ptlayout='setxkbmap pt'
alias eulayout='setxkbmap eu'
#
###########################
#  __                     #
# |  \. _ _ _|_ _  _. _ _ #
# |__/|| (-(_|_(_)| |(-_) #
#                         #
###########################
#
## Personal ##
alias    down="cd $HOME/Downloads"
alias    docs="cd $HOME/Documents"
alias   music="cd $HOME/Music"    
alias    pics="cd $HOME/Pictures" 
alias   repos="cd $HOME/Repos"    
alias scripts="cd $HOME/Scripts"  
#
################################
#  __                          #  
# /  \   . _|    /\  _ _ _ _ _ #
# \_\/|_||(_|(  /--\(_(_(-_)_) #
#                              #
################################
#
## QUICK ACCESS ##
alias  notes="nvim $HOME/Documents/Notes/TmpNotes"
alias  setup="nvim $HOME/Documents/PersonalNotes/setup-base-system"
alias zalias="nvim $HOME/.config/zsh/aliases.zsh"
alias   zfun="nvim $HOME/.config/zsh/functions.zsh"
alias   zexp="nvim $HOME/.config/zsh/exports.zsh"
alias   zopt="nvim $HOME/.config/zsh/options.zsh"
alias  zplug="nvim $HOME/.config/zsh/plugins.zsh"
alias  zbind="nvim $HOME/.config/zsh/bindings.zsh"
alias   zfix="nvim $HOME/.config/zsh/fixes.zsh"
#
##############
# |_/.|_|_   # 
# | \||_|_\/ #
#         /  #
##############
#
## icat (image cat) ##
alias icat='kitty +kitten icat'
#
#################
#  __           # 
# /  \|_|_  _ _ #
# \__/|_| )(-|  #
#               #
# ###############
#
# Assorted:
alias binds='bindkey -L'
alias kc='killall conky'
#
# Define wallpaper
alias wp='feh --bg-scale'
#
# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'
#
# Cheat sheets:
alias cheat-zle="bat $HOME/Documents/ZLE/zsh_bindings"

## Dotfiles management
alias dot="/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME"
