---------------------------------------------------------------------------------------------------
# Open SSH

sudo apt install openssh-server

pscp <Source_File> <Linux_Username>@<Destination_Address>:<Destination_Directory>
pscp C:\pscp.txt baeldung@linux_server:/home/baeldung/

scp -r C:/desktop/myfolder/deployments/ user@host:/path/to/whereyouwant/thefile
scp -r \desktop\myfolder\deployments\ user@host:/path/to/whereyouwant/thefile

scp [OPTION] [user@]SRC_HOST:]file1 [user@]DEST_HOST:]file2
scp file.txt remote_username@ip_address_of_remote:/remote/directory

sftp username@your_server_ip_or_remote_hostname
sftp -oPort=custom_port username@your_server_ip_or_remote_hostname

