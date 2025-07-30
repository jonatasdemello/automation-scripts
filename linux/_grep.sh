#-------------------------------------------------------------------------------------------------------------------------------
# grep

Search any line that contains the word in filename on Linux:

grep 'word' filename

Perform a case-insensitive search for the word ‘bar’ in Linux and Unix:

grep -i 'bar' file1

Look for all files in the current directory and in all of its subdirectories in Linux for the word ‘httpd’:

grep -R 'httpd' .

Search and display the total number of times that the string ‘nixcraft’ appears in a file named frontpage.md:

grep -c 'nixcraft' frontpage.md

#-------------------------------------------------------------------------------------------------------------------------------
grep [options] pattern [files]

Options Description
-c : This prints only a count of the lines that match a pattern
-h : Display the matched lines, but do not display the filenames.
-i : Ignores, case for matching
-l : Displays list of a filenames only.
-n : Display the matched lines and their line numbers.
-v : This prints out all the lines that do not matches the pattern
-e exp : Specifies expression with this option. Can use multiple times.
-f file : Takes patterns from file, one per line.
-E : Treats pattern as an extended regular expression (ERE)
-w : Match whole word
-o : Print only the matched parts of a matching line,
 with each such part on a separate output line.

-A n : Prints searched line and nlines after the result.
-B n : Prints searched line and n line before the result.
-C n : Prints searched line and n lines after before the result.


cat geekfile.txt

unix is great os. unix is opensource. unix is free os.
learn operating system.
Unix linux which one you choose.
uNix is easy to learn.unix is a multiuser os.Learn unix .unix is a powerful.

#-------------------------------------------------------------------------------------------------------------------------------

# 1. Case insensitive search :
# The -i option enables to search for a string case insensitively in the given file.
# It matches the words like "UNIX", "Unix", "unix".

grep -i "UNix" geekfile.txt

# 2. Displaying the count of number of matches :
# We can find the number of lines that matches the given string/pattern

grep -c "unix" geekfile.txt

# 3. Display the file names that matches the pattern :
# We can just display the files that contains the given string/pattern.

grep -l "unix" *
grep -l "unix" f1.txt f2.txt f3.xt f4.txt

# 4. Checking for the whole words in a file :
# By default, grep matches the given string/pattern even if it is found as a substring in a file.
# The -w option to grep makes it match only the whole words.

grep -w "unix" geekfile.txt

# 5. Displaying only the matched pattern :
# By default, grep displays the entire line which has the matched string.
# We can make the grep to display only the matched string by using the -o option.

grep -o "unix" geekfile.txt

# 6. Show line number while displaying the output using grep -n :
# To show the line number of file with the line matched.

grep -n "unix" geekfile.txt

# 7. Inverting the pattern match :
# You can display the lines that are not matched with the specified search string pattern using the -v option.

grep -v "unix" geekfile.txt

# 8. Matching the lines that start with a string :
# The ^ regular expression pattern specifies the start of a line.
# This can be used in grep to match the lines which start with the given string or pattern.

grep "^unix" geekfile.txt

# 9. Matching the lines that end with a string :
# The $ regular expression pattern specifies the end of a line.
# This can be used in grep to match the lines which end with the given string or pattern.

grep "os$" geekfile.txt

# 10. Specifies expression with -e option. Can use multiple times :

grep –e "Agarwal" –e "Aggarwal" –e "Agrawal" geekfile.txt

# 11. -f file option Takes patterns from file, one per line.

cat pattern.txt

Agarwal
Aggarwal
Agrawal

grep –f pattern.txt  geekfile.txt

# 12. Print n specific lines from a file:
# -A prints the searched line and n lines after the result,
# -B prints the searched line and n lines before the result, and
# -C prints the searched line and n lines after and before the result.

grep -A[NumberOfLines(n)] [search] [file]
grep -B[NumberOfLines(n)] [search] [file]
grep -C[NumberOfLines(n)] [search] [file]

grep -A1 learn geekfile.txt

# 13. Search recursively for a pattern in the directory:
# -R prints the searched pattern in the given directory recursively in all the files.

grep -R [Search] [directory]
grep -iR geeks /home/geeks

Output:

./geeks2.txt:Well Hello Geeks
./geeks1.txt:I am a big time geek
----------------------------------
-i to search for a string case insensitively
-R to recursively check all the files in the directory.

#-------------------------------------------------------------------------------------------------------------------------------
# Overview of extended regular expression syntax

The only difference between basic and extended regular expressions is in the behavior of a few characters: ‘?’, ‘+’, parentheses, braces (‘{}’), and ‘|’. While basic regular expressions require these to be escaped if you want them to behave as special characters, when using extended regular expressions you must escape them if you want them to match a literal character. ‘|’ is special here because ‘\|’ is a GNU extension – standard basic regular expressions do not provide its functionality.

Examples:

abc?            becomes ‘abc\?’ when using extended regular expressions. It matches the literal string ‘abc?’.
a\|b            becomes ‘a|b’ when using extended regular expressions. It matches ‘a’ or ‘b’.
c\+             becomes ‘c+’ when using extended regular expressions. It matches one or more ‘c’s.
a\{3,\}         becomes ‘a{3,}’ when using extended regular expressions. It matches three or more ‘a’s.
\(abc*\)\1      becomes ‘(abc*)\1’ when using extended regular expressions. Backreferences must still be escaped when using extended regular expressions.
\(abc\)\{2,3\}  becomes ‘(abc){2,3}’ when using extended regular expressions. It matches either ‘abcabc’ or ‘abcabcabc’.

