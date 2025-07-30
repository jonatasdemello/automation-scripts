#!/bin/bash
# Passing arguments to a function

#set -x

update () {
  echo updating $1
  cd $1

  git.exe pull --progress -v --no-rebase --tags --prune "origin"

  git remote prune origin
  git gc --auto

  git clean -fd

  echo updated $1
  read -p "Press enter to continue"
  cd ..
}

# git.exe clone --progress -v --depth 3 "https://github.com/<Org>/<repo>.git" "C:\Workspace\<Repo>"

# git clone --depth 1

update repo1
update repo2
update repo3
