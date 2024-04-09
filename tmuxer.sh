#!/bin/bash
#
# Tim de Klijn, 2024
# Quick script to setup a tmux session the way I like it
editor="nvim"

# Setup by searching through project dir and create session name
project=$(find ~/workspace -maxdepth 1 -type d | fzf)
name=$(basename $project)

# Check if session name already.
tmux has-session -t $name 2>/dev/null
if [ $? == 0 ]; then
    # if session exists, attach to it.
    tmux switch -t $name:1
else
    # Setup a new session
    tmux new-session -d -s $name -n CODE -c $project $editor &
    tmux new-window -t $name -n TERM -c $project
    tmux switch -t $name:1
fi

