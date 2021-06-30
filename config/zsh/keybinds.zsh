## vi-mode ###############
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins ' ' magic-space

# history search
bindkey '^R' history-incremental-search-backward

# Shift + Tab
bindkey -M viins '^[[Z' reverse-menu-complete
# bind UP and DOWN arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
