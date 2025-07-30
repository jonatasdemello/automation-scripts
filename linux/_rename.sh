#-------------------------------------------------------------------------------------------------------------------------------
# rename all files

find . -name '*.rhtml' | sed 's/.*/mv -v & &/' | sed 's/\.html$/.html.erb/' | sh

rename .rhtml .html.erb app/views/*/*


find . -name '*.txt' | sed -r 's/.*/mv -v & &/' | sed -r 's/.txt$/.bas/' | sh


#-------------------------------------------------------------------------------------------------------------------------------
# To replace the spaces with underscores

find . -type f -name "* *" | while read file; do mv "$file" ${file// /_}; done


#-------------------------------------------------------------------------------------------------------------------------------
# Rename

rename 's/test-this/REPLACESTRING/g' *

#    s: flag to substitute a string with another string,
#    test-this: the string you want to replace,
#    REPLACESTRING: the string you want to replace the search string with, and
#    g: a flag indicating that all matches of the search string shall be replaced,
#		i.e. if the filename is test-this-abc-test-this.ext the result will be REPLACESTRING-abc-REPLACESTRING.ext.
#
for i in test-this*
do
    mv "$i" "${i/test-this/foo}"
done

rename() {
    for i in $1*
    do
        mv "$i" "${i/$1/$2}"
    done
}

find -name test-this\*.ext | sed 'p;s/test-this/replace-that/' | xargs -d '\n' -n 2 mv

#    1. find all files matching your criteria. If you pass -name a glob expression, don't forget to escape the *.
#    2. Pipe the newline-separated* list of filenames into sed, which will:
#		a. Print (p) one line.
#		b. Substitute (s///) test-this with replace-that and print the result.
#		c. Move on to the next line.
#    3. Pipe the newline-separated list of alternating old and new filenames to xargs, which will:
#		a. Treat newlines as delimiters (-d '\n').
#		b. Call mv repeatedly with up to 2 (-n 2) arguments each time.

for f in *\ *; do mv "$f" "${f// /_}"; done

find . -name "* *" -type d | rename 's/ /_/g'    # do the directories first
find . -name "* *" -type f | rename 's/ /_/g'


find . -depth -name '* *' \
| while IFS= read -r f ; do mv -i "$f" "$(dirname "$f")/$(basename "$f"|tr ' ' _)" ; done


find . -type f -name "* *.xml" -exec bash -c 'mv "$0" "${0// /_}"' {} \;

sudo apt install rename
rename 's/\s/_/g' ./*.xml

for f in *; do mv "$f" `echo $f | tr ' ' '_'`; done

find . -name "* *" -type f | rename -v -n 's/\s/_/g' ./*.sql

# Replace spaces in filenames with underscores

rename 'y/ /\_/' \*

# Convert filenames to lowercase

rename 'y/A-Z/a-z/' \*

# Convert filenames to uppercase

rename 'y/a-z/A-Z/' \*


# https://unix.stackexchange.com/questions/315586/replacing-dots-in-file-name-with-underscores-except-the-extension
# head.body.date.txt to head_body_date.txt

rename 's/\.(?=[^.]*\.)/_/g' *.txt


# Iterate over the filenames, and use Parameter expansion for conversion:

for f in *.*.*.txt; do i="${f%.txt}"; echo mv -i -- "$f" "${i//./_}.txt"; done

# The parameter expansion pattern, ${f//./_} replaces all .s with _s in the filename ($f).

# The above will do a dry-run, to let the actual renaming take place, remove echo:

for f in *.*.*.txt; do i="${f%.txt}"; mv -i -- "$f" "${i//./_}.txt"; done

# If you want to deal with any extension, not just .txt:

for f in *.*.*.*; do pre="${f%.*}"; suf="${f##*.}"; \
                     echo mv -i -- "$f" "${pre//./_}.${suf}"; done

# After checking remove echo for actual action:

for f in *.*.*.*; do pre="${f%.*}"; suf="${f##*.}"; \
                     mv -i -- "$f" "${pre//./_}.${suf}"; done

# Generic, for arbitrary number of dots, at least one:

for f in *.*; do pre="${f%.*}"; suf="${f##*.}"; \
                 mv -i -- "$f" "${pre//./_}.${suf}"; done

#-------------------------------------------------------------------------------------------------------------------------------

find . -name "* *" -type f | rename -v -n 's/ - /_/g' ./*.sql
find . -name "* *" -type f | rename -v -n 's/ /_/g' ./*.sql
find . -name "*-*" -type f | rename -v -n 's/-/_/g' ./*.sql
find . -name "*__*" -type f | rename -v -n 's/__/_/g' ./*.sql
find . -name "*-*" -type f | rename -v -n 's/-/_/g' ./*.sql

find . -name "*.*.sql" -type f | rename -v -n 's/\./_/g' ./*.sql
find . -name "*.*.sql" -type f | rename -v -n 's/Report./Report/g' ./*.sql

find . -name "* *" -type f
find . -name "*.*.sql" -type f


rename -v -n 's/Education\./Education_/g' ./*.sql


grep -E '(\[|\])' Career_Cluster.sql

ls *.sql | sed 's/(\[|\])//g' Career_Cluster.sql
sed -r -i 's/(\[|\])//g' Career_Cluster.sql

sed -r -i 's/(\[|\])//g' *.sql


#-------------------------------------------------------------------------------------------------------------------------------
# rename Command Syntax and Options

# There are three types of Perl regular expressions: match, substitute and translate.
# The rename command uses substitute and translate expressions to change file and directory names.

# Substitute expressions replace a part of the filename with a different string.
# They use the following syntax:

rename [options] 's/[filename element]/[replacement]/' [filename]

# With this syntax, the command renames the file by replacing the first occurrence
# of the filename element with the replacement. In the command above:

#    rename: Invokes the rename command.
#    [options]: Provides an optional argument that changes the way the command executes.
#    s: Indicates a substitute expression.
#    [filename element]: Specifies the part of the filename you want to replace.
#    [replacement]: Specifies a replacement for the part of the current filename.
#    [filename]: Defines the file you want to rename.

# A translate expression translates one string of characters into another, character for character.
# This type of expression uses the following syntax:

rename [options] 'y/[string 1]/[string 2]/' [filename]

# An example of a rename command using a translate expression:

rename 'y/abc/xyz/'

# In this example, every a character in the filename is replaced by an x, every b by a y, and every c by a z.

# The rename command uses the following options:

#    -a: Replaces all the occurrences of the filename element instead of just the first one.
#    -f: Forces an overwrite of existing files.
#    -h: Displays the help text.
#    -i: Displays a prompt before overwriting existing files.
#    -l: Replaces the last occurrence of the filename element instead of the first one.
#    -n: Performs a dry run, making no permanent changes. Best combined with the verbose output (-v).
#    -s: Renames the target instead of the symlink.
#    -v: Shows a verbose version of the output.
#    -V: Displays the command version.

# 1. Change File Extension
# to change the file extension from .txt to .pdf, use:

rename -v 's/.txt/.pdf/' *.txt

# 2. Replacing a Part of a Filename
# Replacing a different part of the filename follows the same syntax.
# To rename example1.txt, example2.txt, and example3.txt to test1.txt, test2.txt, and text3.txt, use:
# Renaming multiple files using the rename command

rename -v 's/example/test/' *.txt

# 3. Delete a Part of a Filename
# Removing a part of the file name using the rename command

rename -v 's/ample//' *.txt

# 4. Rename Files with Similar Names
# Another use for the rename option is to rename files with similar names.
# For instance, if we want to rename files with example and sample in their name to test:
# Renaming multiple files with similar names using the rename command

rename -v 's/(ex|s)ample/test/' *.txt

# 5. Rename Files Character-by-Character
# The rename command also allows you to use translate expressions to rename files on a character-by-character basis.
# For instance, if you want to rename multiple files named example file by replacing the blank space with an underscore (_):
# Removing blank spaces from file names using the rename command

rename -v 'y/ /\_/' *.txt

# 6. Convert Lowercase Characters
# To convert lowercase characters in filenames into uppercase characters, use:
# Converting file names from lowercase to uppercase using the rename command

rename -v 'y/a-z/A-Z/' *.txt

# 7. Convert Uppercase Characters
# The reverse also works if we switch the order of the uppercase and lowercase characters in the expression:

rename -v 'y/A-Z/a-z/' *.TXT


