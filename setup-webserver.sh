#!/bin/bash
dnf update -y
dnf install nginx -y
systemctl start nginx
systemctl enable nginx

cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Cloud Sprint Bank TPC</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 100px; background-color: #f4f6f9; }
        h1 { color: #232f3e; }
        p { color: #5a6b7c; font-size: 18px; }
    </style>
</head>
<body>
    <h1>🚀 Deployment Successful!</h1>
    <p>This server was provisioned and configured completely automatically via a custom Bash User Data script.</p>
    <p>Infrastructure Tier: <strong>Public Web Layer</strong></p>
</body>
</html>
EOF
