# Create a new branch without a commit history

git checkout --orphan temp_branch

# Add all files

git add -A

# Commit the changes to the commit history

git commit -m "Initial commit"

# Delete the main branch

git branch -D main

# Rename the temporary branch to main

git branch -m main

# Force update to our Git repository

git push --force origin main


