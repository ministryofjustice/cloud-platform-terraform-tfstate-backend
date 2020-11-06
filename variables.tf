variable "acl" {
  type        = string
  description = "The canned ACL to apply to the S3 bucket"
  default     = "private"
}

variable "read_capacity" {
  default     = 5
  description = "DynamoDB read capacity units"
}

variable "write_capacity" {
  default     = 5
  description = "DynamoDB write capacity units"
}

variable "force_destroy" {
  description = "A boolean that indicates the S3 bucket can be destroyed even if it contains objects. These objects are not recoverable"
  default     = "false"
}

variable "enable_server_side_encryption" {
  description = "Enable DynamoDB server-side encryption"
  default     = "true"
}

variable "region" {
  type        = string
  description = "AWS Region the S3 bucket should reside in"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "dynamo_table_name" {
  type        = string
  description = "DynamoDB table name"
}

variable "enable_point_in_time_recovery" {
  type        = bool
  description = "Enable DynamoDB point-in-time recovery"
  default     = false
}

variable "tags" {
  type = map(string)
  default = {
    terraform       = true
    contact_email   = "platforms@digital.justice.gov.uk"
    is_production   = true
    owner           = "cloud-platform"
    source_code_url = "https://github.com/ministryofjustice/cloud-platform-infrastructure"
  }
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}
