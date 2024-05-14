# Go Application on AWS EKS
This project deploys a simple Go application on AWS EKS (Elastic Kubernetes Service) using Terraform for infrastructure provisioning. The application is containerized using Docker and managed with Kubernetes resources defined in the `k8s` directory.

### Project Structure
- `Dockerfile`: Defines the Docker container for the Go application.
- `src/main.go`: The source code of the Go application.
- `k8s/`: Contains Kubernetes deployment and service definitions.
- `terraform/`: Contains Terraform configurations for provisioning AWS resources including EKS cluster.

### Terraform Modules
- `ecr`: Sets up an AWS ECR repository for the Docker image.
- `eks`: Configures the AWS EKS cluster.
- `iam`: Manages AWS IAM roles and policies required by EKS.
- `vpc`: Provisions the VPC, subnets, and other networking resources required for EKS.

### Prerequisites
- Docker
- Go 1.15+
- kubectl configured to interact with your Kubernetes cluster
- AWS CLI configured with appropriate credentials
- Terraform

## Setup and Deployment

### Build and push the Docker Image
```bash
- docker build -t <ecr-repo-url>:<tag> .
- docker push <ecr-repo-url>:<tag>

### Running Terraform
- cd terraform
- terraform init
- terraform plan
- terraform apply

### Deploying to Kubernetes
- kubectl apply -f k8s/deployment.yaml
- kubectl apply -f k8s/service.yaml

## Troubleshooting
- aws eks list-clusters
- aws eks describe-cluster --name <cluster-name>
- aws ecr describe-repositories --repository-names <repository-name>
- aws iam list-roles
- aws logs get-log-events --log-group-name <log-group-name> --log-stream-name <log-stream-name>

- kubectl cluster-info
- kubectl get nodes -o wide
- kubectl describe node <node-name>
- kubectl get pods -o wide --all-namespaces
- kubectl logs <pod-name>
- kubectl port-forward pod/<pod-name> 8080:80
- kubectl get deployments
- kubectl top pods
- kubectl top nodes
- kubectl get events --all-namespaces | grep -i failed

- Manage Go dependencies: `go.mod` & `go.sum` files will be created after initializing go with command `go mod tidy' 


