#-------------------------------------------------------------------------------------------------------------------------------
# bash for loop

for f in $( ls ./Functions/*.sql ); do
	#echo $f
	echo sqlcmd -S $SQLDBName -i "$f" -d $SQLDBName -v databasename=$SQLDBName -r0 -I -m11 -b -V 1 -U $SQLuid -P $SQLpwd -f 65001 -a 16384
done



#Declare array with 4 elements
ARRAY=( 'Debian Linux' 'Redhat Linux' 'Ubuntu Linux' )
# get number of elements in the array
ELEMENTS=${#ARRAY[@]}

# echo each element in array
# for loop
for (( i=0;i<$ELEMENTS;i++)); do
	echo ${ARRAY[${i}]}
done

bash check if directory exists
directory="./BashScripting"
if [ -d $directory ]; then
	echo "Directory exists"
else
	echo "Directory does not exists"
fi
