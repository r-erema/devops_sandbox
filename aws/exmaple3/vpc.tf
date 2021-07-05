resource "aws_flow_log" "vpc_flow_logs" {
  log_destination      = aws_s3_bucket.vpc_flow_logs_bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = var.vpc_id
}

resource "aws_s3_bucket" "vpc_flow_logs_bucket" {
  bucket = "vpc-flow-logs-twizar"
  force_destroy = true

  lifecycle_rule {
    id = "transition-vpc-flow-logs-to-glacier"
    enabled = true
    abort_incomplete_multipart_upload_days = "7"
    transition {
      days = var.transition_vpc_flow_logs_to_glacier_delay_days
      storage_class = "GLACIER"
    }
  }

  lifecycle_rule {
    id = "vpc-flow-logs-retention"
    enabled = true

    expiration {
      days = var.vpc_flow_logs_retention_period
    }

  }
}
