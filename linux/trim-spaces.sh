#-------------------------------------------------------------------------------------------------------------------------------
# trim all leading and trailing spaces and tabs from each line in an output.

sed 's/^[ \t]*//;s/[ \t]*$//' < file

echo -e " \t   blahblah  \t  " | sed 's/^[ \t]*//;s/[ \t]*$//'

echo -e " \t   blahblah  \t  " | sed 's/^[ \t]*//;s/[ \t]*$//' | hexdump -C

# 00000000  62 6c 61 68 62 6c 61 68  0a                       |blahblah.|

sed 's/^[[:blank:]]*//;s/[[:blank:]]*$//' < file

echo -e " \t   blahblah  \t  " | sed 's/^[[:blank:]]*//;s/[[:blank:]]*$//'


#	[[:alnum:]]  - [A-Za-z0-9]     Alphanumeric characters
#	[[:alpha:]]  - [A-Za-z]        Alphabetic characters
#	[[:blank:]]  - [ \t]           Space or tab characters only
#	[[:cntrl:]]  - [\x00-\x1F\x7F] Control characters
#	[[:digit:]]  - [0-9]           Numeric characters
#	[[:graph:]]  - [!-~]           Printable and visible characters
#	[[:lower:]]  - [a-z]           Lower-case alphabetic characters
#	[[:print:]]  - [ -~]           Printable (non-Control) characters
#	[[:punct:]]  - [!-/:-@[-`{-~]  Punctuation characters
#	[[:space:]]  - [ \t\v\f\n\r]   All whitespace chars
#	[[:upper:]]  - [A-Z]           Upper-case alphabetic characters
#	[[:xdigit:]] - [0-9a-fA-F]     Hexadecimal digit characters


awk '{$1=$1;print}'

# or shorter:

awk '{$1=$1};1'

# also squeeze sequences of tabs and spaces into a single space.
# That works because when you assign something to one of the fields,
# awk rebuilds the whole record (as printed by print) by joining all fields ($1, ..., $NF) with OFS (space by default).

# To also remove blank lines, change it to

awk '{$1=$1};NF'

# (where NF tells awk to only print the records for which the Number of Fields is non-zero).
# Do not do awk '$1=$1' as sometimes suggested as that would also remove lines whose first field
# is any representation of 0 supported by awk (0, 00, -0e+12...)
