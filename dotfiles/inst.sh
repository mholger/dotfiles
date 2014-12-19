#!/bin/bash

pushd .
cd ~
git clone --no-checkout https://github.com/mholger/dotfiles.git

cd dotfiles
git config core.worktree "../../"

git reset --hard origin/master

popd
