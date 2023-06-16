#!/bin/bash

# Update the system
apt-get update
apt-get upgrade -y

# Install Nginx
apt-get install -y nginx

# Create the HTML webpage
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
  <title>My Webpage</title>
</head>
<body>
  <h1>Welcome to My Webpage</h1>
  <p>This is a simple webpage served by Nginx.</p>
</body>
</html>
EOF

# Configure Nginx to serve the webpage
cat > /etc/nginx/sites-available/mywebpage << EOF
server {
    listen 80;
    server_name 192.168.100.10;

    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOF

# Enable the Nginx configuration
ln -s /etc/nginx/sites-available/mywebpage /etc/nginx/sites-enabled/
nginx -t  # Test Nginx configuration
systemctl restart nginx

# Done! Your web server is set up with Nginx and serving a simple HTML webpage.
