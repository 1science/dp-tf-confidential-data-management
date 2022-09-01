# dp-tf-confidential-data-management

Repo for managing confidential data, roles
and policies in dev and prod environments.

Wiki: https://elsevier.atlassian.net/wiki/spaces/RDP/pages/119600970030676/Terraform+project+for+confidential+data

## Login

```bash
# Choose account aws-rt-dataconfidential-nonprod (dev) or aws-rt-dataconfidential-prod (prod)
aws-adfs login --adfs-host federation.reedelsevier.com --region us-east-2 --role-arn  assumed-role/ADFS-Developer/roberged@science.regn.net --session-duration 14400 --profile dp-bucket
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
terraform import -var-file=./configurations/prod_config.tfvars.json aws_iam_policy.{ressource_name} {arn}
```