terraform {
  backend "s3" {
    bucket = "nikhil-cherukupally-tf"
    key = "main"
    region = "us-east-1"
    dynamodb_table = "nikhil-tf-st-file"
  }
}
