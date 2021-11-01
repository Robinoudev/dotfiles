alias q="exit"

if command -v exa >/dev/null; then
  alias exa="exa --group-directories-first --git";
  alias l="exa -1";
  alias ll="exa -lg";
  alias la="LC_COLLATE=C exa -la";
fi

# Create a reminder with human-readable durations, e.g. 15m, 1h, 40s, etc
r() {
  local time=$1; shift
  sched "$time" "notify-send --urgency=critical 'Reminder' '$@'; ding";
}; compdef r=sched
