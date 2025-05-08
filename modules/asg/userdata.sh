#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Hello from $(hostname -f)" > /var/www/html/index.html

##!/bin/bash
#
## Install nginx
#yum update -y
#yum install -y nginx
#
## Enable and start nginx
#systemctl enable nginx
#systemctl start nginx
#
## Get instance metadata
#INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
#PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
#LAST_OCTET=$(echo $PRIVATE_IP | awk -F '.' '{print $4}')
#
## Determine role
#if [ $((LAST_OCTET % 2)) -eq 0 ]; then
#  ROLE="frontend"
#else
#  ROLE="backend"
#fi
#
## Create a simple dynamic HTML page
#cat <<EOF > /usr/share/nginx/html/index.html
#<!DOCTYPE html>
#<html>
#<head>
#  <title>Welcome from $ROLE</title>
#  <style>
#    body { font-family: Arial; margin: 40px; background: #f7f7f7; }
#    h1 { color: #333; }
#    p  { font-size: 1.2em; }
#  </style>
#</head>
#<body>
#  <h1>Instance Role: $ROLE</h1>
#  <p><strong>Instance ID:</strong> $INSTANCE_ID</p>
#  <p><strong>Private IP:</strong> $PRIVATE_IP</p>
#</body>
#</html>
#EOF
#
## Restart nginx to apply new page
#systemctl restart nginx
#
