variable "AWS_ACCESS_KEY_ID" {
  description = "The AWS Access key"
  type        = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "The AWS Secret key"
  type        = string

}


variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
}

variable "application_name" {
  description = "The name of the Elastic Beanstalk application"
  type        = string
}

variable "application_description" {
  description = "Description of the Elastic Beanstalk application"
  type        = string
}

variable "environment_name" {
  description = "The name of the Elastic Beanstalk environment"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for Elastic Beanstalk environment"
  type        = string
  default     = "t3.micro"
}

variable "artifact_bucket_name" {
  description = "Name of the S3 bucket to store pipeline artifacts"
  type        = string
}

variable "pipeline_name" {
  description = "Name of the CodePipeline"
  type        = string
}

variable "bitbucket_repo" {
  description = "Name of the Bitbucket repository"
  type        = string
}

variable "bitbucket_branch" {
  description = "Branch name in the Bitbucket repository"
  type        = string
  default     = "main"
}

variable "eb_instance_profile" {
  description = "The IAM instance profile for the Elastic Beanstalk EC2 instances"
  type        = string
}

variable "eb_service_role" {
  description = "The IAM service role for Elastic Beanstalk"
  type        = string
}

variable "codepipeline_role_arn" {
  description = "The ARN of the IAM role for CodePipeline"
  type        = string
}

variable "codestar_connection_arn" {
  description = "The ARN of the CodeStar connection to Bitbucket"
  type        = string
}

variable "api_environment_variables" {
  description = "A map of environment variables for the API"
  type        = map(string)
  default     = {}
}

variable "bitbucket_connection_arn" {
  description = "The ARN of the CodeStar connection to Bitbucket"
  type        = string
}

