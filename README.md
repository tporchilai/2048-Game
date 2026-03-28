# 2048 Game - CI/CD Pipeline on AWS

## 🎮 Live Demo
http://13.201.115.7

<img width="760" height="649" alt="game success" src="https://github.com/user-attachments/assets/f58cc253-b075-47e4-994b-7ab630e4f7e2" />


## 🏗️ Architecture
- **Source** → GitHub
- **Build** → AWS CodeBuild + Docker
- **Registry** → Amazon ECR
- **Deploy** → Amazon ECS Fargate
- **Pipeline** → AWS CodePipeline

  <img width="884" height="402" alt="2024 game" src="https://github.com/user-attachments/assets/39725fe2-4e80-4a8e-adf1-97932266af08" />


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
