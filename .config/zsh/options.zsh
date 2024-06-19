#  _____  _____ __  __   ____        __  _                 
# /__  / / ___// / / /  / __ \____  / /_(_)___  ____  _____
#   / /  \__ \/ /_/ /  / / / / __ \/ __/ / __ \/ __ \/ ___/
#  / /_____/ / __  /  / /_/ / /_/ / /_/ / /_/ / / / (__  ) 
# /____/____/_/ /_/   \____/ .___/\__/_/\____/_/ /_/____/  
#                         /_/                              
# Turn off spelling corrections
unsetopt correctall
# Save every command before it is executed (this is different from bash's history -a solution).
setopt inc_append_history
# Retrieve the history file everytime history is called upon.
# Makes history available between terminals.
setopt share_history
# Treat any argument that's not a path as a var (removes the need to reference the var wwith $)
setopt cdable_vars
# Auto cd when entering a path to a dir
setopt auto_cd

setopt auto_pushd
setopt pushdminus
