#!/bin/bash

# ==============================================================================
# Quick script to setup a tmux session for coding the way I like it. It uses
# fzf to help the user select a project and then opens a new tmux session setup
# the way I want it.
#
# Tim de Klijn, 
# 2024
# ==============================================================================

# Set editor to open on the `CODE` window in tmux
EDITOR="nvim"
# Set workspace to search for projects (folders) in
WORKSPACE=~/workspace

# Setup by searching through project dir.
# NOTE: this will return `~/workspace` as one of the options
PROJECT=$(find $WORKSPACE -maxdepth 1 -type d | fzf)

# If ESC is pressed nothing is selected in fzf. Check if the project is empty
# and simply exit.
if [ -z "$var" ]; then
    echo "ERROR: nothing selected"
    exit 1;
fi

# Create a session name
NAME=$(basename $PROJECT)

# Check if session $NAME already exists. If so, simply switch to that session
tmux has-session -t $NAME 2>/dev/null
if [ $? == 0 ]; then
    tmux switch -t $NAME:1
else
    # If no session with $NAME exists, create a new one with two windows open.
    # On the first window, open $EDITOR and on the second run 'git status'
    tmux new-session -d -s $NAME -n CODE -c $PROJECT
    tmux new-window -t $NAME -n TERM -c $PROJECT

    # To not have the windows close after closing the editor we should first
    # create the window and then use `send-keys` to start the commands.
    tmux send-keys -t $NAME:0 $EDITOR Enter
    tmux send-keys -t $NAME:1 "git status" Enter

    # If everything is setup, switch to the session. Specifically to the window
    # with the git status.
    tmux switch -t $NAME:1
fi

