terraform {
    backend "s3" {
        bucket = "temp-k8s-task-backend"
        region = "us-east-1"
        key    = "terraform.tfstate"
    }
}