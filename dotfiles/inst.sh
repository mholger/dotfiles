#!/bin/bash

mkdir ~/dotfiles
cd ~/dotfiles

git clone --no-checkout https://github.com/mholger/dotfiles.git
git config core.worktree "../../"

git reset --hard origin/master

