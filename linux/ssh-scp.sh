# ssh & scp

sudo apt update
sudo apt install openssh-server
sudo systemctl start ssh
sudo systemctl enable ssh
sudo systemctl status ssh

# ssh
ip a
ssh username@ip_address

# secure
sudo nano /etc/ssh/sshd_config

# 1. Find the line #Port 22 and change it to a port number of your choice, e.g., Port 2222. Save the file and exit.
# 2. Disable Root Login: It’s recommended to disable root login over SSH for security reasons. In the same configuration file, find the line PermitRootLogin and change it to no.

sudo systemctl restart ssh

# SCP

#1. Copy a File from Local to Remote:

scp /path/to/local/file username@remote_ip:/path/to/remote/directory

# 2. Copy a File from Remote to Local:

scp username@remote_ip:/path/to/remote/file /path/to/local/directory

# 3. Copy a Directory Recursively: To copy entire directories, use the -r flag.

scp -r /path/to/local/directory username@remote_ip:/path/to/remote/directory