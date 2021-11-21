## vi-mode ###############
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins ' ' magic-space

# history search
bindkey '^R' history-incremental-search-backward

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# auto suggest accept
bindkey '^f' autosuggest-accept

# edit command in vim

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

# have ctrs + left/right move over a word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
