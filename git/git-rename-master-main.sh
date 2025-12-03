#!/bin/bash

# rename master->main branch

git branch -m master main
git fetch origin
git branch -u origin/main main
git remote set-head origin -a
