#---------------------------------------------------------------------------------------------------
# grep search 

grep -i -E 's/test/test123/g' -r /path/file

grep -i -E 's/test/test123/g' -r *

# using params text file

grep -i -E -f file.txt -r /path/tile

grep -i -E -f file.txt -r *

grep -i -E -f grep-search.txt -r .


#---------------------------------------------------------------------------------------------------
# sed replace

sed -i -r 's/unix/linux/g' file.txt

# -i  overwrites the original file. (edit files in-place)
# -r  use extended regular expressions
# -f  use script file

# using rules file

sed -f sed-rules.sed FF-bookmarks.html > FF-bookmarks1.html

#---------------------------------------------------------------------------------------------------
# find and replace

find . -type f -exec sed -i -E -f sed-rules.sed {} \;

#---------------------------------------------------------------------------------------------------
# search

grep -i -E -f /c/workspace/git/grep-search.txt -r .

# replace

find . -type f -not -path ".git" -exec sed -i -E -f /c/workspace/git/sed-rules.sed {} \;

find . -type f -path "./.git" -prune -o -print

find . -type f -path "./.git" -prune -exec sed -i -E -f /c/workspace/git/sed-rules.sed {} \;

find . -type f -path "./.git" -prune -exec sed -i -E 's/CC3_CMS/DB/g' {} \;


find . \( -path "./dir1" -prune -o -path "./dir2" -prune \) -o -print


ignore:
./.git
doc, xls, xlsx, rtf, pdf

