#!/usr/bin/env bash
set -o pipefail -o errexit
export aws_bootstrap_region="us-east-2"

COMPONENT=$(basename `git rev-parse --show-toplevel`)

if [[ $# -lt 1 ]]; then
    echo "Usage: $(basename $0) requires an environment name(dev, prod, tooling and infradev"
    exit 1
fi

ENVIRONMENT=$1

#accounts id
if [ ${ENVIRONMENT} == "dev" ]; then
   ACCOUNT_ID="210275200797"
   AWS_ACCOUNT_ALIAS="aws-rt-dataconfidential-nonprod"
   CONFIG_BUCKET="com-elsevier-rdp-dataconfidential-nonprod-useast2-1"
fi
##########

s3_state_prefix=tfstate/${ENVIRONMENT}/${AWS_ACCOUNT_ALIAS}

function terraform_init {
    # cleanup cached stuff
    # rm -rf .terraform
    terraform init -backend-config="bucket=${CONFIG_BUCKET}" \
      -backend-config="key=$s3_state_prefix-${COMPONENT}.tfstate" \
      -backend-config="acl=bucket-owner-full-control" \
      -backend-config="region=${aws_bootstrap_region}" \
      -backend-config="dynamodb_table=tf-state-lock-dataplatform-${ENVIRONMENT}"
}


function terraform_plan {
    terraform plan -var-file=./configurations/${ENVIRONMENT}_config.tfvars.json -lock=false
}


terraform_init
terraform_plan