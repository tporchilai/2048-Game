#  2048 Game — Production CI/CD Pipeline on AWS



**A fully automated, containerized deployment of the classic 2048 game using a production-grade AWS CI/CD pipeline.**

[🎮 Live Demo](http://13.201.115.7) • [📖 Architecture](#-architecture) • [🚀 Pipeline](#-cicd-pipeline-flow) • [⚙️ Setup](#%EF%B8%8F-setup-guide)

</div>

---

##  Project Overview

This project demonstrates a **real-world DevOps workflow** where a simple web game is containerized using Docker and deployed automatically to the cloud every time code is pushed to GitHub. The entire deployment process — from building the Docker image to running it in production — is **fully automated** with zero manual intervention.

---

##  Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         AWS Cloud                               │
│                                                                 │
│   ┌──────────┐    ┌──────────────┐    ┌─────┐    ┌─────────┐    │
│   │  GitHub  │──▶│ CodePipeline │───▶│ ECR │──▶│   ECS   │    │ 
│   │   Repo   │    │              │    │     │    │ Fargate │    │
│   └──────────┘    └──────┬───────┘    └─────┘    └─────────┘    │
│                          │                                      │
│                   ┌──────▼───────┐                              │
│                   │  CodeBuild   │                              │
│                   │ (Docker Build)│                             │ 
│                   └──────────────┘                              │
└─────────────────────────────────────────────────────────────────┘
```

| Layer | Service | Purpose |
|-------|---------|---------|
| Source | GitHub | Version control & pipeline trigger |
| Orchestration | AWS CodePipeline | Connects and automates all stages |
| Build | AWS CodeBuild | Compiles Docker image in the cloud |
| Registry | Amazon ECR | Stores and versions Docker images |
| Compute | Amazon ECS Fargate | Runs containerized app serverlessly |
| Config | buildspec.yml | Defines build instructions for CodeBuild |
| Container | Dockerfile | Defines the application container |

---

##  CI/CD Pipeline Flow

```
Developer pushes code to GitHub
            │
            ▼
   AWS CodePipeline triggers
            │
     ┌──────┴──────┐
     │             │
     ▼             ▼
 [Stage 1]     [Stage 2]        [Stage 3]
  SOURCE   ──▶  BUILD    ──▶    DEPLOY
  GitHub       CodeBuild        Amazon ECS
               + Docker
               + ECR Push
```

### Stage 1 — Source
- GitHub repository is monitored for any new commits
- On every `git push`, CodePipeline is triggered automatically
- Source code is packaged and passed to the next stage

### Stage 2 — Build
- AWS CodeBuild pulls the source code
- Docker image is built using the `Dockerfile`
- Image is tagged as `latest` and pushed to **Amazon ECR**
- `imagedefinitions.json` is generated for ECS deployment

### Stage 3 — Deploy
- CodePipeline passes the new image definition to **Amazon ECS**
- ECS performs a **rolling update** — replacing old containers with new ones
- Zero downtime deployment ensures the game stays accessible during updates

---

##  Project Structure

```
2048-Game/
│
├── 2048.html          # Complete 2048 game (HTML + CSS + JS)
├── Dockerfile         # Container configuration using NGINX
├── buildspec.yml      # AWS CodeBuild build instructions
└── README.md          # Project documentation
```

---

## Dockerfile Explained

```dockerfile
FROM nginx:alpine
# Uses lightweight NGINX web server (~5MB image size)
# Alpine Linux base = minimal attack surface + fast pulls

COPY 2048.html /usr/share/nginx/html/index.html
# Places the game file into NGINX's web root directory

EXPOSE 80
# Opens port 80 for HTTP traffic
```

---

##  buildspec.yml Explained

```yaml
version: 0.2

phases:
  pre_build:
    commands:
      # Authenticate Docker with Amazon ECR
      - aws ecr get-login-password --region ap-south-1 | docker login ...

  build:
    commands:
      # Build the Docker image from Dockerfile
      - docker build -t 2048-game .
      # Tag it with the ECR repository URI
      - docker tag 2048-game:latest <ECR_URI>:latest

  post_build:
    commands:
      # Push the image to ECR
      - docker push <ECR_URI>:latest
      # Generate deployment file for ECS
      - printf '[{"name":"2048-game","imageUri":"%s"}]' <ECR_URI>:latest > imagedefinitions.json

artifacts:
  files:
    - imagedefinitions.json
    # Passed to CodePipeline for ECS deployment
```

---

##  Setup Guide

### Prerequisites
- AWS Account with appropriate IAM permissions
- GitHub Account
- AWS CLI installed and configured
- Git installed

### Step 1 — Clone Repository
```bash
git clone https://github.com/tporchilai/2048-Game.git
cd 2048-Game
```

### Step 2 — Configure AWS CLI
```bash
aws configure
# Enter Access Key ID
# Enter Secret Access Key
# Region: ap-south-1
# Output: json
```

### Step 3 — Create ECR Repository
```bash
aws ecr create-repository \
  --repository-name game/2048_game \
  --region ap-south-1
```

### Step 4 — Create ECS Cluster
```bash
aws ecs create-cluster \
  --cluster-name game-2048-cluster \
  --region ap-south-1
```

### Step 5 — Set Up CodePipeline
1. Go to AWS Console → CodePipeline
2. Create pipeline with:
   - **Source:** GitHub (this repo)
   - **Build:** AWS CodeBuild
   - **Deploy:** Amazon ECS

### Step 6 — Push Code to Trigger Pipeline
```bash
git add .
git commit -m "Initial deployment"
git push origin master
```

The pipeline will automatically build and deploy! 

---

##  How Auto-Deploy Works

```bash
# Make any change to the game
echo "<!-- update -->" >> 2048.html

# Push to GitHub
git add .
git commit -m "Update game"
git push origin master

# Pipeline automatically:
# 1. Detects the push
# 2. Builds new Docker image
# 3. Pushes to ECR
# 4. Deploys to ECS
# 5. Game updates live! 
```

---
---

##  Key DevOps Concepts Demonstrated

- ✅ **Infrastructure as Code** — All AWS resources defined and reproducible
- ✅ **Containerization** — App packaged in Docker for consistency
- ✅ **Continuous Integration** — Auto-build on every code push
- ✅ **Continuous Deployment** — Auto-deploy to production
- ✅ **Immutable Infrastructure** — New containers replace old ones
- ✅ **Rolling Updates** — Zero downtime deployments
- ✅ **Private Registry** — Secure image storage with ECR
- ✅ **Serverless Compute** — No server management with Fargate

---

##  Screenshots


<img width="760" height="649" alt="game success" src="https://github.com/user-attachments/assets/8090d5ac-733e-4325-b330-5309ee82d11a" />


| Pipeline Success | Live Game |
|-----------------|-----------|
| All 3 stages green ✅ | Accessible at public IP 🎮 |

---

## Author

**tporchilai**
- GitHub: [@tporchilai](https://github.com/tporchilai)

---

## License

This project is open source and available under the [MIT License](LICENSE).

---

