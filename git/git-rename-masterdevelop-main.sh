# rename Main branch from "develop" to "main"

# rename developer->main branch

git branch -m develop main
git fetch origin
git branch -u origin/main main
git remote set-head origin -a
