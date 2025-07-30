# Concatenate Files With a Separator
# https://www.baeldung.com/linux/concatenate-files-separator


$ for f in *.txt; do
	cat $f >> out.txt;
	echo >> out.txt;
done;

# The find command looks for all the txt files
# using the -exec option, we can cat them to produce the out.txt file.
# we can add more -exec option to insert newlines between the files:

$ find *.txt -exec cat {} \; > out.txt
$ find *.txt -exec cat {} \; -exec echo \; > out.txt
$ find *.txt | xargs -I{} sh -c "cat {}; echo" > out.txt

# using sed

$ sed '' *.txt > out.txt
$ echo "test end of line" | sed '$s/$/\n/'

# a new line is inserted after the text input. Let’s breakdown the sed command part:
#    $s – selects range as the last line
#    $ – second symbol stands for the end of the line
#    \n – is the substitute for the end of the line

# to insert a new line between the files:
# the -s option of the sed command. That’ll make sed to process the files separately, and we get a new line at the end of each file.

$ sed -e '$s/$/\n/' *.txt > out.txt
$ sed -e '$s/$/\n/' -s *.txt > out.txt

# using awk
$ awk '{print $0}' *.txt > out.txt
$ awk '{print $0} END{printf "\n"}' *.txt > out.txt
$ awk '{ if (FILENAME != file){ if (file) printf "\n"; file = FILENAME } } {print $0} END{printf "\n"}'


