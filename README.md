# dp-tf-confidential-data-management

Repo for managing confidential data, roles
and policies in dev and prod environments.

## Login

```bash
# Choose account aws-rt-dataconfidential-nonprod (dev) or aws-rt-dataconfidential-prod (prod)
aws-adfs login --adfs-host federation.reedelsevier.com --region us-east-2 --role-arn  assumed-role/ADFS-Developer/{USERNAME}@science.regn.net --session-duration 14400 --profile dp-bucket
# Choose account aws-rt-dataplatform-nonprod (dev) or aws-rt-dataplatform-prod (prod)
aws-adfs login --adfs-host federation.reedelsevier.com --region us-east-2 --role-arn  assumed-role/ADFS-Developer/{USERNAME}@science.regn.net --session-duration 14400 --profile dp-cluster
export AWS_PROFILE="dp-bucket"
```

## Terraform plan and apply

```bash
cd terraform
./terraform_run {dev|prod}
terraform apply out/out.bin
```

## Import a ressource

Example with a IAM policy:
```bash
terraform import -var-file=./configurations/dev_config.tfvars.json aws_iam_policy.{ressource_name} {arn}
```