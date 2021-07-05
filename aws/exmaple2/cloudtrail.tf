data "aws_caller_identity" "current" {}

resource "aws_cloudtrail" "cloudtrail-logs" {
  name                          = "cloudtrail-logs"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_logs_bucket.id
  include_global_service_events = true
}

resource "aws_s3_bucket" "cloudtrail_logs_bucket" {
  bucket        = "cloudtrail-logs-bucket-twizar"
  force_destroy = true

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::cloudtrail-logs-bucket-twizar"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::cloudtrail-logs-bucket-twizar/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY

  lifecycle_rule {
    id = "transition-cloudtrail-logs-to-glacier"
    enabled = true
    abort_incomplete_multipart_upload_days = "7"
    transition {
      days = var.transition_cloudtrail_logs_to_glacier_delay_days
      storage_class = "GLACIER"
    }
  }

  lifecycle_rule {
    id = "retention"
    enabled = true

    expiration {
      days = var.cloudtrail_logs_retention_period
    }
  }

}
