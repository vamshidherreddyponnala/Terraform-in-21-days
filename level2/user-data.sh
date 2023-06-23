#!/bin/bash

yum update -y
yum install -y httpd

# Create index.html file
echo "Hello from instance $(hostname)" > /var/www/html/index.html

# Set correct file permissions
chmod 644 /var/www/html/index.html

# Start httpd service
systemctl start httpd
systemctl enable httpd







# #!/bin/bash

# yum update -y
# yum install -y httpd git

# # git clone https://github.com/gabrielecirulli/2048.git
# # cp -R 2048/* /var/www/html
# echo "Hello from instance $(hostname)" > /var/www/html/index.html
# systemctl start httpd && systemctl enable httpd



