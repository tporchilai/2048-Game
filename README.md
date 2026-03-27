# 2048 Game - CI/CD Pipeline on AWS

## 🎮 Live Demo
http://13.201.115.7

## 🏗️ Architecture
- **Source** → GitHub
- **Build** → AWS CodeBuild + Docker
- **Registry** → Amazon ECR
- **Deploy** → Amazon ECS Fargate
- **Pipeline** → AWS CodePipeline

## 🚀 How It Works
1. Push code to GitHub
2. CodePipeline triggers automatically
3. CodeBuild builds Docker image
4. Image pushed to Amazon ECR
5. ECS Fargate deploys new container

## 🛠️ Technologies Used
- HTML, CSS, JavaScript
- Docker
- AWS CodePipeline
- AWS CodeBuild
- Amazon ECR
- Amazon ECS Fargate

## 📦 Setup
1. Clone the repo
2. Configure AWS credentials
3. Push to GitHub
4. Pipeline auto-deploys!