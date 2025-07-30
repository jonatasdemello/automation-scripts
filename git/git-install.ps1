
# install
winget install --id Git.Git -e --source winget
winget install --id TortoiseGit.TortoiseGit -e --source winget

runas /noprofile /user:Administrator cmd


Synopsis:
  elevate [(-c | -k) [-n] [-u]] [-w] command

Options:
  -c  Launches a terminating command processor; equivalent to "cmd /c command".
  -k  Launches a persistent command processor; equivalent to "cmd /k command".
  -n  When using -c or -k, do not pushd the current directory before execution.
  -u  When using -c or -k, use Unicode; equivalent to "cmd /u".
  -w  Waits for termination; equivalent to "start /wait command".


# show config
git config --list --show-origin

file:C:/Program Files/Git/etc/gitconfig diff.astextplain.textconv=astextplain
file:C:/Program Files/Git/etc/gitconfig filter.lfs.clean=git-lfs clean -- %f
file:C:/Program Files/Git/etc/gitconfig filter.lfs.smudge=git-lfs smudge -- %f
file:C:/Program Files/Git/etc/gitconfig filter.lfs.process=git-lfs filter-process
file:C:/Program Files/Git/etc/gitconfig filter.lfs.required=true
file:C:/Program Files/Git/etc/gitconfig http.sslbackend=openssl
file:C:/Program Files/Git/etc/gitconfig http.sslcainfo=C:/Program Files/Git/mingw64/etc/ssl/certs/ca-bundle.crt
file:C:/Program Files/Git/etc/gitconfig core.autocrlf=true
file:C:/Program Files/Git/etc/gitconfig core.fscache=true
file:C:/Program Files/Git/etc/gitconfig core.symlinks=true
file:C:/Program Files/Git/etc/gitconfig pull.rebase=false
file:C:/Program Files/Git/etc/gitconfig credential.helper=manager
file:C:/Program Files/Git/etc/gitconfig credential.https://dev.azure.com.usehttppath=true
file:C:/Program Files/Git/etc/gitconfig init.defaultbranch=master

