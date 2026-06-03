# Week 1: Linux and Git Mastered
## Logging and Troubleshooting Commands
- tail -f /var/log/nginx/access.log : Watches web traffic logs live.
- journalctl -u nginx.service  : Shows the historical log and crash reports for Nginx 



## Week 2: Networking Foundations
- Port 22: SSH (Remote Management)
- Port 80: HTTP (Unencrypted Web)
- Port 443: HTTPS (Encrypted Web)
- Connection Timeout: Usually means a Layer 4 Firewall (Security Group) is dropping packets silently
- CIDR /32: Represents exactly 1 unique IP address. 


## Week 3: AWS VPC Infrastructure
- Created a custom VPC with CIDR block '10.0.0.0/16' for maximum internal network footprint.
- Carved out a 'public-web-subnet' ('10.0.1.0/24') and a 'private-db-subnet' ('10.0.2.0/24') in the same Availability Zone.\
- Deployed a 'bank-production-igw' (Internet Gateway) and attached it to the VPC edge.
- Configured a custom Route Table mapping '0.0.0.0/0' (all external internet traffic) to the Internet Gateway, and explicitly associated it *only* with the public subnet to ensure complete isolation of the database tier.


## Week 4: AWS EC2 Compute & Cloud Web Deployment
- Provisioned an Amazon Linux 2023 't3.micro' EC2 instance inside the custom 'public-web-subnet'.
- Configured a Layer 4 Security Group acting as a firewall, restricting SSH access (Port 22) to my personal IP address while opening HTTP access (Port 80) globally (`0.0.0.0/0`).
- Established a secure cryptographic handshake connection using an RSA private key file ('.pem') with 'chmod 400' security compliance.
- Remotely initialized the server via SSH, updated packages via 'dnf', and deployed a highly available Nginx web server background process.


## Week 5: Configuration Automation & Shell Scripting
- Automated the entire server provisioning pipeline using an asynchronous AWS User Data lifecycle script.
- Eliminated manual SSH overhead by executing system package updates, software installation, and background daemon configuration dynamically at boot time.
- Implemented a standard Linux 'Heredoc' ('cat <<EOF') pattern to inject automated custom HTML deployment indicators directly into system storage directories.
- Saved core automation routine to 'setup-webserver.sh' for multi-region scalability.

## Cloud Storage & Databases
### Week 6: Object Storage Foundations
- Evaluated block storage topology (Amazon EBS) vs. globally decoupled object storage frameworks (Amazon S3).
- Provisioned a production-tier private S3 storage bucket under a strict global namespace with 'Block All Public Access' compliance to protect static assets.
- Mitigated credential-leakage risks by defining Least-Privilege access strategies, favoring temporary IAM Instance Profiles over hardcoded static AWS Access Keys for EC2-to-S3 infrastructure integration.


## Cloud Security & IAM
### Week 7: Machine Identities & Policy Enforcement
- Engineered a secure, passwordless machine-to-machine authentication pipeline using AWS IAM Roles and Instance Profiles.
- Audited and decrypted IAM JSON policy structures, mapping explicitly allowed API actions (`s3:Get*`, `s3:List*`) against global cloud resources.
- Validated the 'Principle of Least Privilege' by verifying cryptographic execution of the AWS CLI via the EC2 metadata service, successfully conducting data retrieval while actively blocking unauthorized destructive actions (`AccessDenied` on bucket deletion).


## Cloud Storage & Databases (Cont.)
### Week 8: The Managed Relational Database Tier (RDS)
- Built a multi-Availability Zone private subnet footprint (`private-db-subnet-2`) to satisfy high-availability database cluster parameters.
- Configured an isolated RDS DB Subnet Group and applied strict 'Security Group Chaining' onto `database-sg`, permitting inbound MySQL traffic (Port 3306) exclusively from web-tier firewalls.
- Pivoted away from front-end console configuration constraints by executing a direct AWS CLI engine allocation (`aws rds create-db-instance`) inside the CloudShell terminal environment.
- Provisioned a zero-egress, privately isolated, Free-Tier compliant Amazon RDS MySQL instance completely unreachable by public routing mechanics.


## Core AWS Compute & Automation (Cont.)
### Week 9: High Availability & Traffic Management (ALB)
- Architected a multi-Availability Zone load-balanced public tier (`public-web-subnet-2`) to mitigate Single Points of Failure (SPOF).
- Engineered an AWS Target Group (`bank-web-targets`) passing automated Layer 7 HTTP health checks across decoupled EC2 web endpoints.
- Provisioned an internet-facing Application Load Balancer (ALB) enforcing a dynamic Round-Robin traffic distribution matrix.
- Conducted Chaos Engineering validation by executing an unannounced server power shutdown, verifying immediate sub-minute failover capabilities with 100% application uptime.


## Core AWS Compute & Automation (Cont.)
### Week 10: Auto-Scaling & Self-Healing Systems (ASG)
- Formulated a standard infrastructure configuration blueprint (`bank-web-template`) incorporating automated Apache installation routines via Launch Template user data.
- Deployed a multi-Availability Zone Auto Scaling Group (`bank-web-asg`) mapped across custom public subnets with target-tracking thresholds bound to a 70% CPU metric ceiling.
- Enforced systemic elasticity parameters regulating high-availability bounds across structural Desired (2), Minimum (1), and Maximum (4) operational constraints.
- Executed Chaos Engineering lifecycle degradation tests, validating automated event detection and stateless self-healing compute provisioning without administrative manual intervention.


## Security, Monitoring, & Cost Optimization
### Week 11: CloudWatch Metrics & Monitoring (Alarms)
- Authorized global cross-account governance telemetry by enabling CloudWatch Billing Alerts inside root billing preferences.
- Swapped regional console contexts to the `us-east-1` (N. Virginia) global cost aggregation tier to capture structural account metrics.
- Constructed a static CloudWatch Alarm (`Estimated-Charges-Over-5-Dollars`) mapping the `EstimatedCharges` metric on a 6-hour evaluation frequency.
- Provisioned an automated Simple Notification Service (SNS) messaging topic (`billing-alarm-topic`), binding an email communication endpoint for real-time cost escalation alerts.


## Security, Monitoring, & Cost Optimization (Cont.)
### Week 12: Centralized Logging (CloudWatch Logs Agent)
- Formulated a restrictive Identity & Access Management (IAM) role (`bank-ec2-monitoring-role`) granting secure API write execution via the `CloudWatchAgentServerPolicy`.
- Provisioned a decoupled testing endpoint inside a custom VPC with a modified security group matrix permitting explicit SSH access mapping on Port 22.
- Resolved Amazon Linux 2023 legacy compatibility constraints by deploying the `rsyslog` daemon engine to generate structured cryptographic file targets (`/var/log/secure`).
- Orchestrated a custom CloudWatch Unified Agent JSON configuration matrix mapping dual-stream data ingestion pipelines (`bank-os-security-logs` and `bank-bootstrap-logs`) with a 7-day automated data retention policy.


## Infrastructure as Code (IaC)
### Week 13: Introduction to Terraform (S3 Provisioning)
- Established secure local workstation environment variables mapping AWS programmatic IAM Access Keys for localized API execution.
- Engineered a standard declarative HashiCorp Configuration Language (HCL) deployment matrix (`main.tf`) targeting provider ecosystem constraints.
- Executed core Infrastructure as Code (IaC) engineering lifecycles including initialization (`terraform init`), structural dry-run evaluation (`terraform plan`), and live state application (`terraform apply`).
- Automated the deterministic provisioning of a globally unique, multi-tagged Amazon S3 data bucket cluster completely bypassed from manual console interaction.
