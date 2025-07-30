---------------------------------------------------------------------------------------------------
# RDP

# In this case, we’ll use xrdp, an RDP server for Linux.

# So let’s install xrdp on our Ubuntu system:

sudo apt install xrdp -y

# Next, we’ll install the Xfce environment on our Ubuntu system:

sudo apt install xfce4 -y

# After this, we’ll configure xrdp to use this newly-installed desktop environment:

sudo sed -i.bak '/fi/a #xrdp multiple users configuration \n xfce-session \n' /etc/xrdp/startwm.sh

# Then we’ll enable the default RDP port 3389 via ufw:

sudo ufw allow 3389/tcp

# Finally, we’ll restart the xrdp server:

sudo systemctl restart xrdp


# 172.31.18.216
