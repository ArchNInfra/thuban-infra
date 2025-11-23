# Thuban – AWS Infra Baseline

**Thuban** is the foundational infrastructure star of the Constellation System —  
a stable, unshakable baseline providing the AWS core required for all upper-layer services.

This module provides the minimal but production-ready cloud foundation using Terraform.

---

## Scope

Thuban provisions the essential AWS infrastructure components:

### **Core Infrastructure**
- VPC (public + private subnets)
- ECS cluster (Fargate-ready compute baseline)
- ECR registry (container image storage)
- IAM roles & least-privilege policies

### **Terraform Backend**
- **S3 remote backend for state**
- (Note: DynamoDB locking removed due to deprecation)
- State separation by workspace or directory structure

### **Principles**
- Minimal footprint  
- Deterministic & reproducible TF modules  
- Zero unnecessary AWS services  
- Clear separation of execution role vs task role (for services built on top)

---

## Stack

- Terraform
- AWS: VPC / IAM / ECS / ECR
- Backend: **S3 Remote State (no more DynamoDB locking)**

---

## Structure

(To be completed after v0.2)

Suggested layout:

```bash
thuban-infra/
  modules/
  vpc/
  ecs/
  ecr/
  iam/
  backend/
  docs/
```

## Status

### 0.2 — Upcoming
- Add full VPC module (public/private with NAT)  
- Add ECS cluster baseline  
- Add ECR registry module  
- Add S3 backend bootstrap script  

### 0.1 — Repository initialized