#!/bin/bash

pushd .
cd ~
git clone --no-checkout https://github.com/mholger/dotfiles.git

cd dotfiles
git config core.worktree "../../"

git reset --hard origin/master

cd ~
mkdir -p ~/.vim/backup

echo "gitdir: $HOME/dotfiles/.git" > ~/.git
chmod 0700 .ssh
chmod 0600 .ssh/*

popd

git submodule --init --recursive
