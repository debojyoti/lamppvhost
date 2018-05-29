#!/bin/bash

vhostName=$1

# Append in "httpd-vhosts.conf" file
vhostFilePath="/opt/lampp/etc/extra/httpd-vhosts.conf" 
echo "
<VirtualHost *:80>
	DocumentRoot \"/opt/lampp/htdocs/$vhostName\"
	ServerName $vhostName
	<Directory \"/opt/lampp/htdocs/$vhostName\">
		Options All
		AllowOverride All
		Require all granted
	</Directory>
#	ErrorLog \"logs/dummy-host.example.com-error_log\"
#	CustomLog \"logs/dummy-host.example.com-access_log\" common
</VirtualHost>" >> $vhostFilePath

# Append in "hosts" file
hostsFilePath="/etc/hosts" 
echo "127.0.0.1	$vhostName
" >> $hostsFilePath

# Create the directory if don't exists
mkdir -p -- "/opt/lampp/htdocs/$vhostName"
chmod 777 "/opt/lampp/htdocs/$vhostName"

# Restart apache
/opt/lampp/lampp stop
/opt/lampp/lampp start