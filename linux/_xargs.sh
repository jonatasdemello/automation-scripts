#-------------------------------------------------------------------------------------------------------------------------------

# xargs

find [location] -name "[search-term]" -type f | xargs [command]

find . -name "*.txt" -type f | xargs file

# xargs does not automatically include files which contain blank spaces in their names.
# To include those files too, use the -print0 option for find, and the -0 option for xargs:

find [location] -name "[search-term]" -type f -print0 | xargs -0 [command]

# Use xargs with the grep command to search for a string in the list of files provided by the find command.

find . -name '[search-term]' | xargs grep '[string-to-find-in-files]'

#To run more than one command with xargs, use the -I option. The syntax is:

[command-providing-input] | xargs -I % sh -c '[command-1] %; [command-2] %'

cat folderNames.txt | xargs -I % sh -c 'echo %; mkdir %'

# xargs reads the standard input. Use the -a option to read the contents of a file instead.

xargs -a [filename]

# When used with the tar command, xargs creates a tar.gz archive and populates it with files provided by the find command.

find [location] -name "[search-term]" -type f -print0 | xargs -0 tar -cvzf [tar-gz-archive-name]

find ./photos -name "*.png" -type f | xargs tar -cvzf photos.tar.gz

# To see the commands executed by xargs in standard output, use the -t option.

[command-providing-input] | xargs -t [command]

echo "folder1 folder2 folder3" | xargs -t mkdir

# show prompt

[command-providing-input] | xargs -p [command]

echo "file.txt" | xargs -p rm

# Limit Output per Line

[command-providing-input] | xargs -n [number] [command]

echo "1 2 3 4 5 6 7 8 9" | xargs -n 3

# Specify the Delimiter

# The default xargs delimiter is a blank space.
# To change the default delimiter, use the -d command followed by a single character or an escape character such as n (a new line).

[command-providing-input] | xargs -d [new-delimiter] | xargs [command]

echo "folder1@folder2@folder3" | xargs -d @ | xargs ls


cut -d: -f1 < /etc/passwd | sort | xargs

# Remove Blank Spaces in String
# Since xargs ignores blank spaces when looking for arguments, the command is useful for removing unnecessary blank spaces from strings.

echo "[string-with-unnecessary-spaces]" | xargs

echo "   string   with   unnecessary spaces " | xargs

# List Number of Lines/Words/Characters in Each File
# Use xargs with the wc command to display a list of files with the line, word, and character count.

ls | xargs wc

# Copy File to Multiple Directories

echo [directory-1] [directory-2] | xargs -n 1 cp -v [filename]

echo ./dir1 ./dir2 ./dir3 | xargs -n 1 cp -v file.txt



#-------------------------------------------------------------------------------------------------------------------------------

find ./ -name "*.page" -type f -print0 | xargs -0 tar -cvzf page_files.tar.gz


#    find ./ -name “*.page” -type f -print0:
#        The find action will start in the current directory,
#        searching by name for files that match the “*.page” search string.
#        Directories will not be listed because we’re specifically telling it to look for files only, with -type f.
#        The print0 argument tells find to not treat whitespace as the end of a filename.
#        This means that that filenames with spaces in them will be processed correctly.
#    xargs -0: The -0 arguments xargs to not treat whitespace as the end of a filename.
#    tar -cvzf page_files.tar.gz:
#        This is the command xargs is going to feed the file list from find to.
#        The tar utility will create an archive file called “page_files.tar.gz.”

# We can use ls to see the archive file that is created for us.

ls *.gz

find . -name "*.page" -type f -print0 | xargs -0 wc

# This command pipes all the filenames into wc at once.
# Effectively, xargs constructs a long command line for wc with each of the filenames in it.

# If we use xarg‘s  -I (replace string) option and define a replacement string token—in this case
# ” {}“—the token is replaced in the final command by each filename in turn.
# This means wc is called repeatedly, once for each file.

find . -name "*.page" -type f -print0 | xargs -0 -I "{}" wc "{}"

find . -name "*.page" -type f -exec wc -c "{}" \;

#    find .: Start the search in the current directory. The find command is recursive by default, so subdirectories will be searched too.
#        -name “*.page”: We’re looking for files with names that match the “*.page” search string.
#        -type f: We’re only looking for files, not directories.
#        -exec wc: We’re going to execute the wc command on the filenames that are matched with the search string.
#        -w: Any options that you want to pass to the command must be placed immediately following the command.
#        “{}”: The “{}” placeholder represents each filename and must be the last item in the parameter list.
#        \;: A semicolon “;” is used to indicate the end of the parameter list. It must be escaped with a backslash “\” so that the shell doesn’t interpret it.

find . -name "*.page" -type f -exec wc -c "{}" \+

# As you can see there is no total. The wc command is executed once per filename.
# By substituting a plus sign “+” for the terminating semicolon “;” we can change -exec‘s behaviour to operate on all files at once.




