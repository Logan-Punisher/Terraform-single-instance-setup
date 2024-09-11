provider "aws" {
  region = var.aws_region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

# Elastic Beanstalk Application
resource "aws_elastic_beanstalk_application" "app" {
  name        = var.application_name
  description = var.application_description
}

# Elastic Beanstalk Environment
resource "aws_elastic_beanstalk_environment" "env" {
  name                = var.environment_name
  application         = aws_elastic_beanstalk_application.app.name
  solution_stack_name = "64bit Amazon Linux 2023 v6.2.0 running Node.js 18"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.eb_instance_profile
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = var.eb_service_role
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "1"
  }

  # Add environment variables from the API environment file
  dynamic "setting" {
    for_each = var.api_environment_variables
    content {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = setting.key
      value     = setting.value
    }
  }
}

# S3 Bucket for artifacts
resource "aws_s3_bucket" "artifacts" {
  bucket = var.artifact_bucket_name
}

resource "aws_s3_bucket_ownership_controls" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "artifacts" {
  depends_on = [aws_s3_bucket_ownership_controls.artifacts]

  bucket = aws_s3_bucket.artifacts.id
  acl    = "private"
}



# CodePipeline
resource "aws_codepipeline" "pipeline" {
  name     = var.pipeline_name
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = aws_s3_bucket.artifacts.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.bitbucket_connection_arn
        FullRepositoryId = var.bitbucket_repo
        BranchName       = var.bitbucket_branch
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ElasticBeanstalk"
      input_artifacts = ["source_output"]
      version         = "1"

      configuration = {
        ApplicationName = aws_elastic_beanstalk_application.app.name
        EnvironmentName = aws_elastic_beanstalk_environment.env.name
      }
    }
  }
}

