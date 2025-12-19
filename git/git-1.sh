windows
C:\Program Files\Git\etc\gitconfig

Lowest to highest priority:

	/etc/gitconfig: 	system wide, edited when --system parameter is used
	~/.gitconfig: 		user specific configuration, edited when --global parameter is used
	.git/config: 		repository specific configuration


gitconfig is local, and not versioned: you would rely on other developers to make the exact same "correct" configuration;
.gitattributes is versioned: other developers will benefit from it automatically;
core.autocrlf would override any .gitattributes carefully set directives.



From the Git manual 
(read http://git-scm.com/docs/git-config#FILES)

If not set explicitly with --file, there are four files where git config will search for configuration options:

$(prefix)/etc/gitconfig

System-wide configuration file.

$XDG_CONFIG_HOME/git/config

Second user-specific configuration file. If $XDG_CONFIG_HOME is not set or empty, $HOME/.config/git/config will be used. Any single-valued variable set in this file will be overwritten by whatever is in ~/.gitconfig. It is a good idea not to create this file if you sometimes use older versions of Git, as support for this file was added fairly recently.

~/.gitconfig

User-specific configuration file. Also called "global" configuration file.

$GIT_DIR/config

Repository specific configuration file.

If no further options are given, all reading options will read all of these files that are available. If the global or the system-wide configuration file are not available they will be ignored. If the repository configuration file is not available or readable, git config will exit with a non-zero error code. However, in neither case will an error message be issued.

The files are read in the order given above, with last value found taking precedence over values read earlier. When multiple values are taken then all values of a key from all files will be used.

-------------------------------------------------------------------------------------------------------------------------------


The easiest way to fix this is to make one commit that fixes all the line endings. Assuming that you don`t have any modified files, then you can do this as follows.

# From the root of your repository remove everything from the index
git rm --cached -r .

# Change the autocrlf setting of the repository (you may want 
#  to use true on windows):
git config core.autocrlf input

# Re-add all the deleted files to the index
# (You should get lots of messages like:
#   warning: CRLF will be replaced by LF in <file>.)
git diff --cached --name-only -z | xargs -0 git add

# Commit
git commit -m "Fixed crlf issue"

# If you're doing this on a Unix/Mac OSX clone then optionally remove
# the working tree and re-check everything out with the correct line endings.
git ls-files -z | xargs -0 rm
git checkout .


The git documentation for gitattributes now documents another approach for "fixing" or normalizing all the line endings in your project. Here's the gist of it:

$ echo "* text=auto" >.gitattributes
$ git add --renormalize .
$ git status        # Show files that will be normalized
$ git commit -m "Introduce end-of-line normalization"



The git documentation for gitattributes now documents another approach for "fixing" or normalizing all the line endings in your project. Here's the gist of it:

$ echo "* text=auto" >.gitattributes
$ git add --renormalize .
$ git status        # Show files that will be normalized
$ git commit -m "Introduce end-of-line normalization"
If any files that should not be normalized show up in git status, unset their text attribute before running git add -u.

manual.pdf      -text

Conversely, text files that git does not detect can have normalization enabled manually.

weirdchars.txt  text

This leverages a new --renormalize flag added in git v2.16.0, released Jan 2018.
But it may fail if you have "un-staged deleted files", hence stage those first, like:

git ls-files -z --deleted | xargs -0 git add
For older versions of git, there are a few more steps:

$ echo "* text=auto" >>.gitattributes
$ rm .git/index     # Remove the index to force git to
$ git reset         # re-scan the working directory
$ git status        # Show files that will be normalized
$ git add -u
$ git add .gitattributes
$ git commit -m "Introduce end-of-line normalization"

The best explanation of how core.autocrlf works is found on the gitattributes man page, in the text attribute section.

This is how core.autocrlf appears to work currently (or at least since v1.7.2 from what I am aware):

core.autocrlf = true
Text files checked-out from the repository that have only LF characters are normalized to CRLF in your working tree; files that contain CRLF in the repository will not be touched
Text files that have only LF characters in the repository, are normalized from CRLF to LF when committed back to the repository. Files that contain CRLF in the repository will be committed untouched.
core.autocrlf = input
Text files checked-out from the repository will keep original EOL characters in your working tree.
Text files in your working tree with CRLF characters are normalized to LF when committed back to the repository.
core.autocrlf = false
core.eol dictates EOL characters in the text files of your working tree.
core.eol = native by default, which means working tree EOLs will depend on where git is running: CRLF on a Windows machine, or LF in *nix.
Repository gitattributes settings determines EOL character normalization for commits to the repository (default is normalization to LF characters).
I've only just recently researched this issue and I also find the situation to be very convoluted. The core.eol setting definitely helped clarify how EOL characters are handled by git.

╔═══════════════╦══════════════╦══════════════╦══════════════╗
║ core.autocrlf ║     false    ║     input    ║     true     ║
╠═══════════════╬══════════════╬══════════════╬══════════════╣
║               ║ LF   => LF   ║ LF   => LF   ║ LF   => CRLF ║
║ git checkout  ║ CR   => CR   ║ CR   => CR   ║ CR   => CR   ║
║               ║ CRLF => CRLF ║ CRLF => CRLF ║ CRLF => CRLF ║
╠═══════════════╬══════════════╬══════════════╬══════════════╣
║               ║ LF   => LF   ║ LF   => LF   ║ LF   => LF   ║
║ git commit    ║ CR   => CR   ║ CR   => CR   ║ CR   => CR   ║
║               ║ CRLF => CRLF ║ CRLF => LF   ║ CRLF => LF   ║
╚═══════════════╩══════════════╩══════════════╩══════════════╝


The issue of EOLs in mixed-platform projects has been making my life miserable for a long time. The problems usually arise when there are already files with different and mixed EOLs already in the repo. This means that:

The repo may have different files with different EOLs
Some files in the repo may have mixed EOL, e.g. a combination of CRLF and LF in the same file.
How this happens is not the issue here, but it does happen.

I ran some conversion tests on Windows for the various modes and their combinations.
Here is what I got, in a slightly modified table:

                 | Resulting conversion when       | Resulting conversion when 
                 | committing files with various   | checking out FROM repo - 
                 | EOLs INTO repo and              | with mixed files in it and
                 |  core.autocrlf value:           | core.autocrlf value:           
--------------------------------------------------------------------------------
File             | true       | input      | false | true       | input | false
--------------------------------------------------------------------------------
Windows-CRLF     | CRLF -> LF | CRLF -> LF | as-is | as-is      | as-is | as-is
Unix -LF         | as-is      | as-is      | as-is | LF -> CRLF | as-is | as-is
Mac  -CR         | as-is      | as-is      | as-is | as-is      | as-is | as-is
Mixed-CRLF+LF    | as-is      | as-is      | as-is | as-is      | as-is | as-is
Mixed-CRLF+LF+CR | as-is      | as-is      | as-is | as-is      | as-is | as-is

As you can see, there are 2 cases when conversion happens on commit (3 left columns). In the rest of the cases the files are committed as-is.

Upon checkout (3 right columns), there is only 1 case where conversion happens when:

core.autocrlf is true and
the file in the repo has the LF EOL.
Most surprising for me, and I suspect, the cause of many EOL problems is that there is no configuration in which mixed EOL like CRLF+LF get normalized.

Note also that "old" Mac EOLs of CR only also never get converted.
This means that if a badly written EOL conversion script tries to convert a mixed ending file with CRLFs+LFs, by just converting LFs to CRLFs, then it will leave the file in a mixed mode with "lonely" CRs wherever a CRLF was converted to CRCRLF.
Git will then not convert anything, even in true mode, and EOL havoc continues. This actually happened to me and messed up my files really badly, since some editors and compilers (e.g. VS2010) don't like Mac EOLs.

I guess the only way to really handle these problems is to occasionally normalize the whole repo by checking out all the files in input or false mode, running a proper normalization and re-committing the changed files (if any). On Windows, presumably resume working with core.autocrlf true.

