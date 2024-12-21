terraform {
  backend "s3" {
    bucket = "ramratan-bucket-2510"        # Your S3 bucket name
    key    = "terraform/statefile.tfstate"  # The key path for the state file in the bucket
    region = "us-east-1"              # The region where the S3 bucket is located
  }
}