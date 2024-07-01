###############################################################################
#                                 ZSH OPTIONS                                 #
###############################################################################
# Turn off spelling corrections
unsetopt correctall

# Save every command before it is executed (this is different from bash's history -a solution).
setopt inc_append_history
# Retrieve the history file everytime history is called upon.
# Makes history available between terminals.
setopt share_history

# Treat any argument that's not a path as a var (removes the need to reference the var wwith $)
setopt cdable_vars
# Automatically change to a directory entered at the prompt
setopt auto_cd
# Automatically add directory to the directory stack with cd
setopt auto_pushd
# Swap the meaning of 'cd +1' and 'cd -1'
setopt pushdminus
