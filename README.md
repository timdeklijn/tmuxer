# TMUXER

## WHAT?

A small script to open `tmux` session in a subfolder of `~/workspace`. It will
open two windows: one names `CODE` with an editor open and one names `TERM` with
nothing open.

## WHY?

Speed up switching `tmux` sessions and opening up windows + editor. This (for
me) is quite similar for all projects, so I simply automated this.

## Install

First clone this repo. In a directory in your path, create a soft link (`ln -s`)
called `t` to the `tmuxer.sh` script in this repo.
