# 🚀 Terraform AWS EC2 Nginx Web Server

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?logo=amazonaws)
![EC2](https://img.shields.io/badge/AWS-EC2-orange)
![Nginx](https://img.shields.io/badge/Nginx-WebServer-009639?logo=nginx)
![Linux](https://img.shields.io/badge/Linux-Amazon%20Linux-yellow?logo=linux)

## 📌 Project Overview

This project demonstrates how to provision cloud infrastructure using **Infrastructure as Code (IaC)** with **Terraform** on **Amazon Web Services (AWS)**.

The goal is to deploy a production-style EC2 web server environment with:

- Custom **VPC networking**
- Secure **Security Group configuration**
- Automated **Nginx installation via user-data**
- **Dynamic AMI discovery**
- Infrastructure outputs for operational visibility

The server is fully provisioned using Terraform and automatically configured at launch to serve a web page.

---

## 🧠 Key Skills Demonstrated

- Infrastructure as Code (IaC)
- AWS networking fundamentals
- Secure infrastructure configuration
- Terraform workflow (`init → plan → apply`)
- EC2 provisioning
- Automated server bootstrapping
- Debugging EC2 cloud-init failures
- Clean repository and state management

---

## 🛠 Technologies Used

- AWS EC2
- Terraform
- Amazon Linux 2
- Nginx
- Cloud-init (user-data bootstrapping)
- Git / GitHub

---

## 🏗 Architecture
```
Internet
│
Internet Gateway
│
Route Table
│
Public Subnet
│
Security Group
│
EC2 Instance
│
Nginx Web Server
```

📸 Screenshot  
![Architecture](architecture-diagram.png)
---

Infrastructure deployed:

- VPC
- Public Subnet
- Internet Gateway
- Route Table + Association
- Security Group
- EC2 Instance
- Nginx Web Server

---

## 🌐 VPC Network Created

The infrastructure runs inside a custom AWS Virtual Private Cloud (VPC) with a public subnet and internet gateway to allow inbound web traffic.

📸 Screenshot  
![VPC Created](vpc-created.png)

## 📂 Project Structure

```
terraform-aws-ec2-webserver
│
├── provider.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── user-data.sh
├── .gitignore
├── README.md
├── Architecture
└── screenshots
```

---

## ⚙️ Infrastructure Deployment Workflow

### 1️⃣ Initialize Terraform

terraform init
Downloads the AWS provider and initializes the working directory.

📸 Screenshot
![Terraform intitialization](terraform-init.png)

## 2️⃣ Review Infrastructure Plan

terraform plan
This command previews the infrastructure Terraform will create.

📸 Screenshot  
![Terraform plan](terraform-plan.png)

---

## 3️⃣ Deploy Infrastructure

terraform apply
Terraform provisions the infrastructure and launches the EC2 instance.

📸 Screenshot  
![Terraform Apply](terraform-apply-success.png)
![Instance Running](ec2-instance-running.png)

---

# ⚙️ EC2 Bootstrapping (User Data)

The EC2 instance automatically installs and starts Nginx during launch using a bootstrap script.

**user-data.sh**
```
#!/bin/bash

yum update -y
amazon-linux-extras install nginx1 -y

systemctl start nginx
systemctl enable nginx

echo "<h1>Terraform Production Project</h1>" > /usr/share/nginx/html/index.html
```

This ensures the web server is fully configured **without manual intervention**.

---

# 🔐 Security Configuration

The Security Group allows inbound access on:

| Port | Purpose |
|------|-------|
|  22  |  SSH |
|  80  | HTTP |

📸 Screenshot  
![Security Group](security-group-rules.png)

---

# 🌐 Web Server Verification

Once the infrastructure is deployed, the web server becomes accessible using the EC2 public IP address.
http://<EC2-PUBLIC-IP>

📸 Screenshot  
![Nginx Active](nginx-browser-success.png)

---

# 📊 Terraform Outputs

Terraform provides useful information after deployment.

Example output:
```
Outputs:
instance_public_ip = 54.xxx.xxx.xxx
instance_id = i-xxxxxxxx
```
📸 Screenshot  
![Terraform Outputs](terraform-output.png)

---

# 🧩 Key Engineering Decisions

### Dynamic AMI Lookup

Instead of hardcoding AMI IDs, Terraform dynamically retrieves the latest Amazon Linux image.

### Separate Bootstrap Script

The EC2 configuration script is stored in `user-data.sh` to keep Terraform configuration clean and maintainable.

### Terraform State Protection

Terraform state files are excluded using `.gitignore` to prevent sensitive infrastructure information from being uploaded to GitHub.

---

# 🧠 Lessons Learned

During deployment, the initial bootstrap failed because **Nginx was not available in the default Amazon Linux repository**.

By inspecting **cloud-init logs**, the correct installation method using **Amazon Linux Extras** was identified and implemented.

This troubleshooting step ensured a fully automated and reliable deployment.

You can write reusable and sharable code using terraform module.

---

# 🚀 Future Improvements

- Add Application Load Balancer
- Implement Auto Scaling Group
- Add CloudWatch monitoring
- Use remote Terraform state with S3 and DynamoDB

---

# 👤 Author

**Chisom Eze**
```
Cloud Engineer 
Focused on building reliable, and production ready cloud infrastructure using Infrastructure as Code.
```

