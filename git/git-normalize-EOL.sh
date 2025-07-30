# https://docs.github.com/en/get-started/getting-started-with-git/configuring-git-to-handle-line-endings#re-normalizing-a-repository

# Line ending normalization
git config --global core.autocrlf false


Use
echo "$(perl -pe 's/\r\n?//')" filename > filename

if you do not have dos2unix.


# to convert from Windows-style text to Unix-style text:

perl -pe 's/\r$//g' < windows_file.txt > unix_file.txt

# To convert from Unix-style text to Windows-style text:

perl -pe 's/(?<!\r)\n/\r\n/g' < unix_file.txt > windows_file.txt

crlf file.txt --to lf       # change crlf to lf
crlf file.txt --to crlf     # change lf to crlf
crlf -R directory/ --to lf  # recursive


# OK
dos2unix filename

# this works
find . -type f -exec dos2unix {} \;

find . -type f -exec grep -qIP '\r\n' {} ';' -exec perl -pi -e 's/\r\n/\n/g' {} '+'


find . -type f | file -f -
find . -type f -exec file -- {} +