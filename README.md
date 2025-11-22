Here’s a **README.md** for your Terraform project with a simple architecture diagram. You can expand or modify it later.

---

# Terraform AWS ALB + EC2 Project

## **Project Overview**

This Terraform project deploys a simple web application infrastructure on AWS, consisting of:

* **VPC** with public subnets
* **Internet Gateway** for internet access
* **Route Tables** associated with subnets
* **Security Groups** for ALB and EC2
* **Application Load Balancer (ALB)** with a listener
* **Target Groups** and **Target Group Attachments**
* **Two EC2 Instances** running Apache HTTP server

The architecture ensures that the web servers are publicly accessible via the ALB, and traffic is restricted by security groups.

---

## **Architecture Diagram**

```
                 +---------------------------+
                 |   AWS Application LB      |
                 |  (HTTP:80)                |
                 +-------------+-------------+
                               |
                -------------------------------
                |                             |
         +------+-----+                 +------+-----+
         |  EC2 Web1  |                 |  EC2 Web2  |
         | 10.0.1.10  |                 | 10.0.2.10  |
         +------------+                 +------------+
                |                             |
       Security Group: ec2_sg           Security Group: ec2_sg
       Allow HTTP from ALB              Allow HTTP from ALB

        Public Subnet1 (10.0.1.0/24)   Public Subnet2 (10.0.2.0/24)
                 \                             /
                  \                           /
                   +-------------------------+
                   |       VPC Main          |
                   +-------------------------+
                   | Internet Gateway (IGW)  |
                   +-------------------------+
```

---

## **Pre-requisites**

* Terraform >= 1.4
* AWS CLI configured with the profile used in provider (`default`)
* An S3 bucket for storing Terraform state (`anjainaybackendcode123`)

---

## **Project Structure**

```
.
├── provider.tf          # AWS provider and S3 backend
├── vpc.tf               # VPC resource
├── subnets.tf           # Public subnets
├── igw.tf               # Internet Gateway
├── route_table.tf       # Route table and associations
├── security_groups.tf   # Security groups for ALB and EC2
├── alb.tf               # Application Load Balancer
├── target_group.tf      # ALB target group
├── listener.tf          # ALB listener
├── ec2.tf               # EC2 instances
├── outputs.tf           # Outputs (optional)
└── README.md
```

---

## **Usage**

1. Initialize Terraform:

```bash
terraform init
```

2. Validate configuration:

```bash
terraform validate
```

3. Plan changes:

```bash
terraform plan
```

4. Apply configuration:

```bash
terraform apply
```

5. Verify deployed resources in AWS console.

---

## **Outputs**

* ALB DNS name
* EC2 public IPs (optional)
* Security group IDs (optional)

---

## **Notes**

* Ensure subnet availability zones match the AWS region.
* Security groups are set to allow HTTP traffic only from ALB.
* Replace AMI IDs with valid IDs for your region.

---
yes

