# list current kernel
ls -1 /boot/vm*

uname -a

# List all installed kernels in Your OS:

dpkg --list | egrep -i --color 'linux-image|linux-headers|linux-modules' | awk '{ print $2 }'


# Uninstall kernels You don't need:

sudo apt purge linux-headers-5.6.11-050611  linux-headers-5.6.11-050611-lowlatency linux-image-unsigned-5.6.11-050611-lowlatency linux-modules-5.6.11-050611-lowlatency

sudo apt-get purge linux-*-*-5.*

#---------------------------------------------------------------------------------------------------
# clean-up /var/lib/snapd/snaps

sudo bash -c 'rm /var/lib/snapd/cache/*'

#!/bin/sh
LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
while read pkg revision; do
  sudo snap remove "$pkg" --revision="$revision"
done

#---------------------------------------------------------------------------------------------------

remove_old_kernels.sh

#!/bin/bash
# Run this script without any param for a dry run
# Run the script with root and with exec param for removing old kernels after checking
# the list printed in the dry run

uname -a
IN_USE=$(uname -a | awk '{ print $3 }')
echo "Your in use kernel is $IN_USE"

OLD_KERNELS=$(
    dpkg --list |
        grep -v "$IN_USE" |
        grep -Ei 'linux-image|linux-headers|linux-modules' |
        awk '{ print $2 }'
)
echo "Old Kernels to be removed:"
echo "$OLD_KERNELS"

if [ "$1" == "exec" ]; then
    for PACKAGE in $OLD_KERNELS; do
        yes | apt purge "$PACKAGE"
    done
else
    echo "If all looks good, run it again like this: sudo remove_old_kernels.sh exec"
fi

#---------------------------------------------------------------------------------------------------

Run it like this for a dry run:

remove_old_kernels.sh

If all looks good, run it again like this:

sudo remove_old_kernels.sh exec

#---------------------------------------------------------------------------------------------------

# Write all the current kernels you have on a file.

dpkg --list | egrep -i --color 'linux-image|linux-headers|linux-modules' | awk '{ print $2 }' > kernels.txt

# Filter your currently used kernel out of the file using grep.

grep -v $(uname -r) kernels.txt > kernels_to_delete.txt

# Verify your current kernel is not present in the delete list. Don't skip this. Ensures you don't mistakenly delete all the kernels.

grep $(uname -r) kernels_to_delete.txt

# Delete all the unused kernels in one go.

cat kernels_to_delete.txt | xargs sudo apt purge -y

#---------------------------------------------------------------------------------------------------

#!/bin/bash -e
# Run this script without any arguments for a dry run
# Run the script with root and with exec arguments for removing old kernels and modules after checking
# the list printed in the dry run

uname -a
IN_USE=$(uname -a | awk '{ print $3 }')
echo "Your in use kernel is $IN_USE"

OLD_KERNELS=$(
    dpkg --get-selections |
        grep -v "linux-headers-generic" |
        grep -v "linux-image-generic" |
        grep -v "linux-image-generic" |
        grep -v "${IN_USE%%-generic}" |
        grep -Ei 'linux-image|linux-headers|linux-modules' |
        awk '{ print $1 }'
)
echo "Old Kernels to be removed:"
echo "$OLD_KERNELS"

OLD_MODULES=$(
    ls /lib/modules |
    grep -v "${IN_USE%%-generic}" |
    grep -v "${IN_USE}"
)
echo "Old Modules to be removed:"
echo "$OLD_MODULES"

if [ "$1" == "exec" ]; then
  apt-get purge $OLD_KERNELS
  for module in $OLD_MODULES ; do
    rm -rf /lib/modules/$module/
  done
fi

