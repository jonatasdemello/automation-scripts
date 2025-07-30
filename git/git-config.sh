-------------------------------------------------------------------------------------------------------------------------------
# Line ending normalization

# References:

# https://git-scm.com/docs/gitattributes

# https://docs.github.com/en/get-started/getting-started-with-git/configuring-git-to-handle-line-endings#re-normalizing-a-repository

# https://stackoverflow.com/questions/3206843/how-line-ending-conversions-work-with-git-core-autocrlf-between-different-operat
# https://stackoverflow.com/questions/2825428/why-should-i-use-core-autocrlf-true-in-git
# https://markentier.tech/posts/2021/10/autocrlf-true-considered-harmful/

-------------------------------------------------------------------------------------------------------------------------------
# install Git and TortoiseGit

winget install --id Git.Git -e --source winget
winget install --id TortoiseGit.TortoiseGit -e --source winget

-------------------------------------------------------------------------------------------------------------------------------
# Clone
git clone https://github.com/<Org>/<Repo>.git

git checkout -b <branch-name> <origin/branch_name>

git clone -b <branch> <remote_repo>

git clone -b my-branch git@github.com:user/myproject.git

git clone -b jm-test-eol https://github.com/<Org>/<Repo>.git

git clone -b jm-test-eol https://github.com/<Org>/<Repo>.git <Repo>-2

-------------------------------------------------------------------------------------------------------------------------------
# Diff

# diff color
git config --global diff.wsErrorHighlight all
git config --global color.diff.whitespace "red reverse"

git config diff.wsErrorHighlight all
git config color.diff.whitespace "red reverse"

git diff -R

-------------------------------------------------------------------------------------------------------------------------------

# command with list and show-origin swtiches run on Windows:
git config --list --show-origin

# edit
sudo git config --edit --global
sudo git config --edit --system
sudo git config --global core.editor "'C:/Program Files/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"

# user
git config --global user.name "Name"
git config --global user.email "user@mail.com"

# check
git config --global user.name
git config --global user.email

# get
git config --global core.eol
git config --global core.fileMode
git config --global core.autocrlf

# change config

# For the current repository
git config core.filemode false

# Globally

git config --global core.autocrlf false
git config --global core.eol lf
git config --global core.safecrlf warn


git config --global core.filemode false
git config --global core.safecrlf false

git config --global core.autocrlf true
git config --global core.autocrlf input
git config --global core.autocrlf false



# remove
git config unset --global core.autocrlf
git config unset --global core.safecrlf

git config unset --global core.autocrlf

# To update all files on the current branch to reflect the new configuration, run the following commands.
git rm -rf --cached .
git reset --hard HEAD

git rm -r --cached . ; git reset --hard

git clean -f -d
# (test)
git clean -n -f -d

git reset --hard origin/master



git diff -b

warning: in the working copy of CRLF will be replaced by LF the next time Git touches it

warning: in the working copy of 'Types/StringList.sql', CRLF will be replaced by LF the next time Git touches it
warning: in the working copy of 'Views/Solr_vwCourses.sql', CRLF will be replaced by LF the next time Git touches it
warning: in the working copy of 'Views/Solr_vwDisciplines.sql', CRLF will be replaced by LF the next time Git touches it

-------------------------------------------------------------------------------------------------------------------------------
