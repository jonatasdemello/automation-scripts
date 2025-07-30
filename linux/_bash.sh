#-------------------------------------------------------------------------------------------------------------------------------

    spaces
    https://www.cyberciti.biz/tips/handling-filenames-with-spaces-in-bash.html

    replace
    https://stackoverflow.com/questions/13210880/replace-one-substring-for-another-string-in-shell-script


    time script.sh
    https://www.baeldung.com/linux/bash-calculate-time-elapsed

    Command in a variable
    https://unix.stackexchange.com/questions/444946/how-can-we-run-a-command-stored-in-a-variable


#-------------------------------------------------------------------------------------------------------------------------------
# 1 word per line

cat text.txt | xargs -n 1

echo um, dos, tres | egrep -o '\w+'

cat text.txt | egrep -o '\w+' | gep ... | sort | uniq -c | sort -n -r | head -n 15

#-------------------------------------------------------------------------------------------------------------------------------
# ls directories only

ls -d */
ls -l | egrep -v '^d'

#-------------------------------------------------------------------------------------------------------------------------------
# ls filenames only

find ./  -printf "%f\n"

#-------------------------------------------------------------------------------------------------------------------------------
# find filenames with spaces or dots

find . -type f -name "* *"
find . -type f -name "*[[:space:]]*"

find . -type f -name "* *.sql"
find . -type f -name "*.*.sql"

#-------------------------------------------------------------------------------------------------------------------------------
# files not conaining string

grep -riL "foo" .

grep -L "foo"

ack -L foo

grep -rL "foo" ./* | grep -v "\.svn"

find .  -not  -ipath '.*svn*' -exec  grep  -H -E -o -c  "foo"  {} \; | grep 0

# or
git grep -L "foo"
git grep -L "foo" -- **/*.cpp

#-------------------------------------------------------------------------------------------------------------------------------
# paste - join files

paste number state capital
paste -d "|" number state capital
paste -d "|," number state capital
paste -s number state capital
paste -s -d ":" number state capital

#-------------------------------------------------------------------------------------------------------------------------------

cat cidades.csv | tr -d \" | tr , '\t' | sed -n l
cat cidades.csv | tr -d \" | tr , '\t' > cidades.txt
cat cidades.txt | cut -f 2

paste file1.txt file2.txt | expand -t 20
paste file1.txt file2.txt | cut -f 1,3

paste file1.txt file2.txt | cut -f 1,3 | sed 's/\(.*\) \(.*\)/..\1..\2../'


cat comments.txt | grep -v "^See translation" | grep -v "^Data [0-9]"


#-------------------------------------------------------------------------------------------------------------------------------
# split in multiple files

seq 20 > 20.txt

# divide 5 lines file
split -l 5 20.txt

# print 1,5 lines
sed -n '1,5 p' 20.txt

# write lines 4,11 to foo.txt file
sed -n '4,11 w foo.txt' 20.txt
sed -n '1,5  w foo1.txt' 20.txt
sed -n '6,10 w foo2.txt' 20.txt

seq 1 5 20 > a1
seq 5 5 20 > a2

paste a1 a2
paste <(seq 1 5 20) <(seq 5 5 20)
paste -d , <(seq 1 5 20) <(seq 5 5 20)
paste -d , <(seq 1 5 20) <(seq 5 5 20) | sed 's/.*/& w linhas-&.txt/ ; s/,/-/2' > foo.sed
sed -n -f foo.sed 20.txt

paste -d , <(seq 1 5 20) <(seq 5 5 20) | sed 's/.*/& w linhas-&.txt/ ; s/,/-/2' | sed -n -f - 20.txt
paste -d , <(seq 1 5 20) <(seq 5 5 20) | sed 's/.*/& w linhas-&.txt/ ; s/,/-/2' | sed -n -f /dev/stdin 20.txt



#-------------------------------------------------------------------------------------------------------------------------------
# string inside double quotes

grep -oP '"\K[^"\047]+(?=["\047])'
grep -Eo '["\047].*["\047]'

# \047  is the octal ascii representation of the single quote

grep -o '"[^"]\+"'

grep -o '"[^"]\+"' file.txt
grep -o '"[^"]\+"' file.txt | sed 's/"//g'



#-------------------------------------------------------------------------------------------------------------------------------

grep ^: changelog.txt | sed 's/^: //'
grep ^: changelog.txt | cut -c 3- | grep '[0-9]'
grep ^: changelog.txt | cut -c 3- | grep '[0-9]' | grep v | sed 's/^v/200/'| tr . - | sed 's/./&x/7' | sed 's/--/-/' | grep ..........

grep ^: changelog.txt | cut -c 3- | grep '[0-9]' | grep v | sed 's/^v/200/'| tr . - | sed 's/./&x/7' | sed 's/--/-/' | egrep '.{10}'



find ./img -name \*.png | sed 's@^http://aurelio.net/@' | grep -v /icon/ | pbcopy


#-------------------------------------------------------------------------------------------------------------------------------
# Insert a new line after every N lines?

# Using paste

paste -d'\n' - - /dev/null <file

sed n\;G <infile
seq 6 | sed n\;G
sed 'n;$!G' <infile

sed '0~2G'
sed 'n;G'
sed '0~2 a\\' inputfile

seq 10 | sed -n '0~4p'
seq 10 | sed -n '1~3p'

# first ~ step
# Match every step'th line starting with line first. For example,
# sed -n 1~2p will print all the odd-numbered lines in the input stream,
# and -n 2~5 will match every fifth line, starting with the second.
# first can be zero; in this case, sed operates as if it were equal to step.

sed -e 'p;s/.*//;H;x;/\n\{2\}/{g;p};x;d'

# sed -e '             # Start a sed script.
#          p            # Whatever happens later, print the line.
#          s/.*//       # Clean the pattern space.
#          H            # Add **one** newline to hold space.
#          x            # Get the hold space to examine it, now is empty.
#          /\n\{2\}/{   # Test if there are 2 new lines counted.
#              g        # Erase the newline count.
#              p        # Print an additional new line.
#            }          # End the test.
#          x            # match the `x` done above.
#          d            # don't print anything else. Re-start.
#        '              # End sed script.

sed  'N;s/.*/&\nLINE/' file

awk '1;!(NR%2){print "LINE";}' file
awk '1 ; NR%2==0 {printf"\n"} '
awk '{ l=$0; getline; printf("%s\n%s\n\n", l, $0) }'
awk ' {print;} NR % 2 == 0 { print ""; }' inputfile




# -----------------------------------------------------------
# With bash:

#!/bin/bash
lines=0
while IFS= read -r line
do
    printf '%s\n' "${line}"
    ((lines++ % 2)) && echo
done < "$1"


# -----------------------------------------------------------

sed '0~3 s/$/\nINSERT/g' < INPUT_FILE_NAME.txt > OUTPUT_FILE_NAME.txt

awk '(++n==3) {print "INSERT"; n=0} (/Header/) {n=0} {print}' file


