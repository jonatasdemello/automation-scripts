# push all branches:
#  (replace REMOTE with the name of the remote, for example "origin"):

git push REMOTE '*:*'
git push REMOTE --all

To push all your tags:

git push REMOTE --tags

# Finally, I think you can do this all in one command with:

git push REMOTE --mirror

