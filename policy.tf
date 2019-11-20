# https://docs.aws.amazon.com/AmazonECR/latest/userguide/RepositoryPolicyExamples.html#IAM_allow_other_accounts
data "aws_iam_policy_document" "readers_writers" {
  statement {
    principals {
      type        = "AWS"
      identifiers = var.writers
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = var.readers
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]
  }
}

data "aws_iam_policy_document" "readers" {
  statement {
    principals {
      type        = "AWS"
      identifiers = var.readers
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]
  }
}

data "aws_iam_policy_document" "writers" {
  statement {
    principals {
      type        = "AWS"
      identifiers = var.writers
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]
  }
}
