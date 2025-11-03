# Removing Snap is perfectly safe as of 24.04. So don't worry. :)

snap list

# Replace existing Snaps that you actually use with proper Debian packages and migrate their config. 
# For Firefox, I recommend the official Ubuntu PPA [# add-apt-repository ppa:mozillateam/ppa]. 
# Switch to ESR while you're at it.

snap list

# For each Snap listed, 

snap remove --purge «snap»

apt remove --purge snapd

apt-mark hold snapd

# Delete the snap directory in all home directories. 
# So, /home/*/snap, but some daemons have them in their home dirs, too. 
# Use # find / -type d -name snap to find candidates.


