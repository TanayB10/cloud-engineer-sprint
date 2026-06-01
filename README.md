# Week 1: Linux and Git Mastered
## Logging and Troubleshooting Commands
- tail -f /var/log/nginx/access.log : Watches web traffic logs live.
- journalctl -u nginx.service  : Shows the historical log and crash reports for Nginx 



##Week 2: Networking Foundations
- Port 22: SSH (Remote Management)
- Port 80: HTTP (Unencrypted Web)
- Port 443: HTTPS (Encrypted Web)
- Connection Timeout: Usually means a Layer 4 Firewall (Security Group) is dropping packets silently
- CIDR /32: Represents exactly 1 unique IP address. 


##Week 3: AWS VPC Infrastructure
- Created a custom VPC with CIDR block '10.0.0.0/16' for maximum internal network footprint.
- Carved out a 'public-web-subnet' ('10.0.1.0/24') and a 'private-db-subnet' ('10.0.2.0/24') in the same Availability Zone.\
- Deployed a 'bank-production-igw' (Internet Gateway) and attached it to the VPC edge.
- Configured a custom Route Table mapping '0.0.0.0/0' (all external internet traffic) to the Internet Gateway, and explicitly associated it *only* with the public subnet to ensure complete isolation of the database tier.


##Week 4: AWS EC2 Compute & Cloud Web Deployment
- Provisioned an Amazon Linux 2023 't3.micro' EC2 instance inside the custom 'public-web-subnet'.
- Configured a Layer 4 Security Group acting as a firewall, restricting SSH access (Port 22) to my personal IP address while opening HTTP access (Port 80) globally (`0.0.0.0/0`).
- Established a secure cryptographic handshake connection using an RSA private key file ('.pem') with 'chmod 400' security compliance.
- Remotely initialized the server via SSH, updated packages via 'dnf', and deployed a highly available Nginx web server background process.


## Week 5: Configuration Automation & Shell Scripting
- Automated the entire server provisioning pipeline using an asynchronous AWS User Data lifecycle script.
- Eliminated manual SSH overhead by executing system package updates, software installation, and background daemon configuration dynamically at boot time.
- Implemented a standard Linux 'Heredoc' ('cat <<EOF') pattern to inject automated custom HTML deployment indicators directly into system storage directories.
- Saved core automation routine to 'setup-webserver.sh' for multi-region scalability.
