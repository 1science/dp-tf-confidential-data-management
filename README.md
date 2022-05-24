# dp-tf-confidential-data-management

Repo for managing confidential data, roles
and policies in dev and prod environments.

## Login

```bash
aws-adfs login --adfs-host federation.reedelsevier.com --region us-east-2 --role-arn  assumed-role/ADFS-Developer/{USERNAME}@science.regn.net --session-duration 14400 --profile dp-dev
# Choose account aws-rt-dataconfidential-nonprod (dev) or aws-rt-dataconfidential-prod (prod)
export AWS_PROFILE="dp-test"
```

## Terraform plan and apply

```bash
cd terraform
./terraform_run {dev|prod}
terraform apply out/out.bin
```