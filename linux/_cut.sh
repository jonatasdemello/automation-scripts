#-------------------------------------------------------------------------------------------------------------------------------
# cut

# byte
cut -b 1 employees.txt
cut -b 1-12 file.txt

# character
cut -c 10- employees.txt
cut -c 1-8,18- employees.txt

# delimiter
echo "phoenixNAP is a global IT services provider" | cut -d ' ' -f 2-4

# fields
cut -f 2 employees.txt
cut -d: -f1,6 /etc/passwd
cut employees.txt -f 1 --complement
cut employees.txt -f 1,3 --output-delimiter='_'


# 1. -b(byte): To extract the specific bytes,
# you need to follow -b option with the list of byte numbers separated by comma.
# Range of bytes can also be specified using the hyphen(-).
# It is necessary to specify list of byte numbers otherwise it gives error.
# Tabs and backspaces are treated like as a character of 1 byte

cut -b 1,2,3 state.txt

# List with ranges

cut -b 1-3,5-7 state.txt

# In this, 1- indicate from 1st byte to end byte of a line

cut -b 1- state.txt

# In this, -3 indicate from 1st byte to 3rd byte of a line

cut -b -3 state.txt

# 2. -c (column): To cut by character use the -c option.
# This selects the characters given to the -c option.
# This can be a list of numbers separated comma or a range of numbers separated by hyphen(-).
# Tabs and backspaces are treated as a character.
# It is necessary to specify list of character numbers otherwise it gives error with this option.

cut -c [(k)-(n)/(k),(n)/(n)] filename

# Here, k denotes the starting position of the character
# and n denotes the ending position of the character in each line,
# if k and n are separated by "-" otherwise they are only the position of character in each line
# from the file taken as an input.

cut -c 2,5,7 state.txt

# Above cut command prints second, fifth and seventh character from each line of the file.

cut -c 1-7 state.txt

# Above cut command prints first seven characters of each line from the file.
# Cut uses a special form for selecting characters from beginning upto the end of the line:

cut -c 1- state.txt

# Above command prints starting from first character to end. Here in command only starting
# position is specified and the ending position is omitted.

cut -c -5 state.txt

# Above command prints starting position to the fifth character. Here the starting position
# is omitted and the ending position is specified.

# 3. -f (field):
# -c option is useful for fixed-length lines.
# Most unix files doesn’t have fixed-length lines.
# To extract the useful information you need to cut by fields rather than columns.
# List of the fields number specified must be separated by comma.
# Ranges are not described with -f option.
# cut uses tab as a default field delimiter but can also work with other delimiter by using -d option.
# Note: Space is not considered as delimiter in UNIX.

cut -d "delimiter" -f (field number) file.txt

# Like in the file state.txt fields are separated by space if -d option is not used then it prints whole line:

cut -f 1 state.txt

# If -d option is used then it considered space as a field separator or delimiter:

cut -d " " -f 1 state.txt

# Command prints field from first to fourth of each line from the file.

cut -d " " -f 1-4 state.txt

# 4. –complement: As the name suggests it complement the output.
# This option can be used in the combination with other options either with -f or with -c.

cut --complement -d " " -f 1 state.txt

cut --complement -c 5 state.txt

# 5. –output-delimiter:
# By default the output delimiter is same as input delimiter that we specify in the cut with -d option.
# To change the output delimiter use the option –output-delimiter="delimiter".

cut -d " " -f 1,2 state.txt --output-delimiter='%'

# Here cut command changes delimiter(%) in the standard output between the fields which is specified by using -f option .
# 6. –version: This option is used to display the version of cut which is currently running on your system.

cut --version

# Applications of cut Command

# 1. How to use tail with pipes(|):
# The cut command can be piped with many other commands of the unix.
# In the following example output of the cat command is given as input
# to the cut command with -f option to sort the state names coming from file state.txt in the reverse order.

cat state.txt | cut -d ' ' -f 1 | sort -r

# It can also be piped with one or more filters for additional processing.
# Like in the following example, we are using cat,
# head and cut command and whose output is stored in the file name list.txt using directive(>).

cat state.txt | head -n 3 | cut -d ' ' -f 1 > list.txt

