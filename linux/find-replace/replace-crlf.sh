# Dos2Unix - replace CRLF => LF

find . -type f -print0 | xargs -0 dos2unix

find . -type f -print0 | xargs -0 -n 1 -P 4 dos2unix

This will pass 1 file at a time, and use 4 processors.

to standardize line endings for all files committed to a Git repository:

git ls-files -z | xargs -0 dos2unix

Keep in mind that certain files (e.g. *.sln, *.bat) are only used on Windows operating systems and should keep the CRLF ending:

git ls-files -z '*.sln' '*.bat' | xargs -0 unix2dos
