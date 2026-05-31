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
