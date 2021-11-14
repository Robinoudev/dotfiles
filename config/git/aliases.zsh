#!/usr/bin/env zsh

g() { [[ $# = 0 ]] && git status --short . || git $*; }

alias git='noglob git'
alias gfa='git fetch --prune --all'
