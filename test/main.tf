resource "aws_instance" "example_server" {
  ami                         = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID
  instance_type               = "t2.micro"
  
  # Crucial setting for assigning a public IP
  associate_public_ip_address = true
  ebs_optimized = true  
  metadata_options {
        
      http_endpoint = "enabled"
      http_tokens   = "required"
 }

  tags = {
    Name = "PublicInstanceExample"
  }
}

resource "aws_s3_bucket" "public_bucket" {
  bucket = "my-public-demo-bucket"
}

resource "aws_s3_bucket_acl" "public_acl" {
  bucket = aws_s3_bucket.public_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.public_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}