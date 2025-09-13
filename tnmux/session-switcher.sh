#!/bin/bash
session_list=$(tmux list-sessions -F '#{session_name} (#{session_windows} windows) - #{session_last_activity}')

selected_line=$(echo "$session_list" | fzf --prompt=" Select a session: " --height=~50% --border --exit-0)

if [ -n "$selected_line" ]; then
    selected_session_name=$(echo "$selected_line" | awk '{print $1}')
    tmux switch-client -t "$selected_session_name"
fi
