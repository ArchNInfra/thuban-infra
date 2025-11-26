# Thuban — AWS Infra Baseline

Thuban is the foundational infrastructure star of the Constellation System —  
a stable, deterministic AWS baseline providing the cloud substrate required for all upper-layer services.

This module provisions a minimal but production-ready AWS foundation using Terraform.

---

## Scope

Thuban provisions the essential AWS infrastructure components:

### Core Infrastructure
- VPC (public + private subnets)
- ECS Cluster (Fargate)
- ECR Repository
- ALB + Listener + Target Group
- IAM roles (task role, execution role)
- CloudWatch Logs

### Terraform Backend
- S3 remote backend for state  
- Encrypted, versioned, locked via S3  
- State isolation by folder/workspace

### Principles
- Minimal footprint  
- Deterministic and reproducible Terraform modules  
- No unnecessary AWS services  
- Clear separation of infra layer (Thuban) vs. service layer (Alphard)

---

## Architecture

```
                   AWS Account
---------------------------------------------------------
                         |
                 +-------+-------+
                 |    VPC (CIDR) |
                 +-------+-------+
                         |
        +----------------+----------------+
        |                                 |
  Public Subnets                    Private Subnets
   (ALB lives here)                 (ECS tasks run here)
        |                                 |
+-------+--------+                +--------+--------+
|      ALB       |  <----- HC ----|   ECS Service   |
|  Target Group  |                |  (Fargate)      |
+-------+--------+                +--------+--------+
        |                                 |
        |                                 |
        |                         Container: Alphard
        v
Internet traffic
```

---

## Components

### VPC
- 2 public subnets  
- 2 private subnets  
- Internet gateway  
- Route tables

### ALB
- HTTP listener  
- Health check: `/health`  
- Target group: port 8000  

### ECS
- Cluster  
- Fargate service  
- Task definition (image from ECR)  
- Task execution role  
- Task role  

### ECR
- Immutable tags  
- Scan on push  

### IAM
- Roles for GitHub Actions (OIDC)
- Task execution + service-linked roles (ECS/ELB)  
- Least privilege policies

### Logging
- CloudWatch Log Group `ecs/alphard`

---

## Usage

### 1. Set AWS credentials

```
export AWS_PROFILE=main
```

### 2. Initialize Terraform

```
terraform init
```

### 3. Apply

```
terraform apply
```

Outputs will include:

- `alphard_alb_dns_name`
- `alphard_ecr_repository_url`
- `alphard_github_actions_role_arn`

---

## Repository Structure

```
thuban-infra/
├── backend.tf
├── backend_resources.tf
├── cluster.tf
├── ecs_service.tf
├── ecs_iam.tf
├── ecr.tf
├── network.tf
├── alb.tf
├── logs.tf
├── variables.tf
├── versions.tf
├── docs/
│   └── architecture.png (optional)
└── README.md
```

---

## Status

### v0.2 — Completed
- ECS/Fargate service for Alphard
- ALB + health check wiring
- IAM roles + service-linked roles
- CloudWatch log pipeline

### v0.1 — Initial
- S3 backend
- VPC scaffolding
- ECR registry

