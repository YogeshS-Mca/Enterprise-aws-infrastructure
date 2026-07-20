#!/bin/bash

set -e

# Record script execution for troubleshooting
exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting EC2 web server configuration..."

# Update installed package metadata
dnf update -y

# Install NGINX
dnf install -y nginx

# Create the custom project webpage
cat > /usr/share/nginx/html/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Enterprise AWS Infrastructure</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f4f7fb;
      margin: 0;
      padding: 40px;
      color: #1f2937;
    }

    .container {
      max-width: 850px;
      margin: auto;
      background: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.10);
    }

    h1 {
      margin-top: 0;
    }

    .status {
      display: inline-block;
      padding: 8px 14px;
      background: #e7f8ed;
      border-radius: 20px;
      font-weight: bold;
    }

    li {
      margin-bottom: 8px;
    }
  </style>
</head>

<body>
  <div class="container">
    <p class="status">Deployment Successful</p>

    <h1>Enterprise AWS Infrastructure</h1>

    <p>
      This web server was provisioned automatically using Terraform
      and configured through EC2 User Data.
    </p>

    <h2>Infrastructure Components</h2>

    <ul>
      <li>Custom Amazon VPC</li>
      <li>Public Subnet</li>
      <li>Internet Gateway</li>
      <li>Public Route Table</li>
      <li>Security Group</li>
      <li>Amazon Linux EC2 Instance</li>
      <li>NGINX Web Server</li>
    </ul>

    <h2>Automation Tools</h2>

    <ul>
      <li>Terraform</li>
      <li>AWS CLI</li>
      <li>Git and GitHub</li>
      <li>EC2 User Data</li>
    </ul>

    <p><strong>Project Owner:</strong> Yogesh</p>
  </div>
</body>
</html>
EOF

# Start NGINX now
systemctl start nginx

# Automatically start NGINX after future reboots
systemctl enable nginx

echo "EC2 web server configuration completed successfully."