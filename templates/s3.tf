## SPDX-FileCopyrightText: Copyright 2019 Amazon.com, Inc. or its affiliates
##
### SPDX-License-Identifier: MIT-0

resource "aws_s3_bucket" "stepfunction_ecs_source_s3bucket" {
  bucket = "${var.app_prefix}-${var.stage_name}-source-bucket-${data.aws_caller_identity.current.account_id}"
  tags = {
    Name        = "${var.app_prefix}-source-s3"
    Environment = "${var.stage_name}"
  }
}

resource "aws_s3_bucket_ownership_controls" "stepfunction_ecs_source_s3bucket" {
  bucket = aws_s3_bucket.stepfunction_ecs_source_s3bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "stepfunction_ecs_source_s3bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.stepfunction_ecs_source_s3bucket]

  bucket = aws_s3_bucket.stepfunction_ecs_source_s3bucket.id
  acl    = "private"
}

# DEPRECATED
# resource "aws_s3_bucket" "stepfunction_ecs_source_s3bucket" {
#   bucket =  "${var.app_prefix}-${var.stage_name}-source-bucket-${data.aws_caller_identity.current.account_id}"
#   acl    = "private"

#   tags = {
#     Name        = "${var.app_prefix}-source-s3"
#     Environment = "${var.stage_name}"
#   }
# }


resource "aws_s3_bucket" "stepfunction_ecs_target_s3bucket" {
  bucket = "${var.app_prefix}-${var.stage_name}-target-bucket-${data.aws_caller_identity.current.account_id}"
  tags = {
    Name        = "${var.app_prefix}-target-s3"
    Environment = "${var.stage_name}"
  }
}

resource "aws_s3_bucket_ownership_controls" "stepfunction_ecs_target_s3bucket" {
  bucket = aws_s3_bucket.stepfunction_ecs_target_s3bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "stepfunction_ecs_target_s3bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.stepfunction_ecs_target_s3bucket]

  bucket = aws_s3_bucket.stepfunction_ecs_target_s3bucket.id
  acl    = "private"
}

# DEPRECATED
# resource "aws_s3_bucket" "stepfunction_ecs_target_s3bucket" {
#   bucket =  "${var.app_prefix}-${var.stage_name}-target-bucket-${data.aws_caller_identity.current.account_id}"
#   acl    = "private"

#   tags = {
#     Name        = "${var.app_prefix}-target-s3"
#     Environment = "${var.stage_name}"
#   }
# }

resource "aws_vpc_endpoint" "stepfunction_ecs_s3_vpc_endpoint" {
  vpc_id       = "${aws_vpc.stepfunction_ecs_vpc.id}"
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"

  tags = {
    Environment = "${var.app_prefix}-s3-vpc-endpoint"
  }
}