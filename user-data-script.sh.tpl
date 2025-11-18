#!/bin/bash
# user-data script to install and start nginx on Amazon Linux (AMI/Amazon Linux 2)
set -e

# Log output for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Update packages
yum update -y

# Try to install nginx using amazon-linux-extras when available (Amazon Linux 2)
if command -v amazon-linux-extras >/dev/null 2>&1; then
  amazon-linux-extras enable nginx1 -y || true
  yum clean metadata
  yum install -y nginx
else
  # Fallback for older Amazon Linux AMIs
  yum install -y nginx
fi

# Ensure nginx is enabled and started
systemctl enable nginx
systemctl start nginx

# Create a simple index page so we can verify nginx is serving
cat > /usr/share/nginx/html/index.html <<'HTML'
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Welcome</title>
  </head>
  <body>
    <h1>Welcome to nginx on $(hostname -f)</h1>
    <p>Installed by user-data script.</p>
  </body>
</html>
HTML

# Print status
echo "nginx installed and started"