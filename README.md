# cloud-platform-terraform-tfstate-backend

**NOTE**: Module inspired by https://github.com/cloudposse/terraform-aws-tfstate-backend. This module doesn't use `terraform-null-label` module for labeling.

Terraform module for provisioning S3 buckets to store `terraform.tfstate` file and a DynamoDB tables for locking the state file (used prevent concurrent modifications and state corruptions).

The module supports the following:

1. Forced server-side encryption at rest for the S3 bucket
2. S3 bucket versioning to allow for Terraform state recovery in the case of accidental deletions and human errors
3. State locking and consistency checking via DynamoDB table to prevent concurrent operations
4. DynamoDB server-side encryption

https://www.terraform.io/docs/backends/types/s3.html


__NOTE:__ The operators of the module (IAM Users) must have permissions to create S3 buckets and DynamoDB tables when performing `terraform plan` and `terraform apply`

__NOTE:__ This module cannot be used to apply changes to the `mfa_delete` feature of the bucket. Changes regarding mfa_delete can only be made manually using the root credentials with MFA of the AWS Account where the bucket resides. Please see: https://github.com/terraform-providers/terraform-provider-aws/issues/62

## How to use

```hcl
module "tf_states_backend" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-tfstate-backend?ref=0.1.1"

  s3_bucket_name = "ale-mogaal-test"
  region = "eu-west-1"
  dynamo_table_name = "ale-mogaal-test"
}
```

Once the bucket and table have been created you should be able to configure [S3 backends in terraform](https://www.terraform.io/docs/backends/types/s3.html)

```hcl
terraform {
  required_version = ">= 0.11.3"
  
  backend "s3" {
    region         = "us-east-1"
    bucket         = "< the name of the S3 bucket >"
    key            = "terraform.tfstate"
    dynamodb_table = "< the name of the DynamoDB table >"
    encrypt        = true
  }
}
```

Initialize the backend with `terraform init`.

After `terraform apply`, `terraform.tfstate` file will be stored in the bucket, 
and the DynamoDB table will be used to lock the state to prevent concurrent modifications.

## Inputs

| Name                        | Description                                                            | Type     | Default | Required |
|-----------------------------|---------------------------------------------------------------         |:--------:|:-------:|:--------:|
