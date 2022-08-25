#!/bin/bash

# CLI setup
cd /tmp/
curl -X GET "https://$VCO_API_URL/api/1/utilities/cli?platform=linux" -H "accept: application/zip" -H  "Authorisation: Bearer $JWT" --output cloud-cli.zip
unzip cloud-cli.zip
rm cloud-cli.zip
CLI_NAME=$(ls)
chmod +x $CLI_NAME
mv $CLI_NAME /usr/bin/
export CLI_NAME
ln -s /usr/bin/$CLI_NAME /usr/bin/ateam

# Terraform Setup
cd /tmp/
curl -X GET "https://$VCO_API_URL/api/1/utilities/terraform-provider?platform=linux" -H "accept: application/zip" -H  "Authorisation: Bearer $JWT" --output terraform-provider.zip
unzip terraform-provider.zip
rm terraform-provider.zip
TF_PROV=$(ls)
echo $TF_PROV
TF_PROV_VER=$(echo $TF_PROV | cut -d _ -f 2 | cut -d v -f 2)
echo $TF_PROV_VER
echo $CLI_NAME
mkdir -p ~/.terraform.d/plugins/registry.terraform.io/$CLI_NAME/$CLI_NAME/$TF_PROV_VER/linux_amd64/
mv $TF_PROV ~/.terraform.d/plugins/registry.terraform.io/$CLI_NAME/$CLI_NAME/$TF_PROV_VER/linux_amd64/
mkdir -p ~/.terraform.d/plugins/registry.terraform.io/ateam/ateam/$TF_PROV_VER/linux_amd64/
ln -s ~/.terraform.d/plugins/registry.terraform.io/$CLI_NAME/$CLI_NAME/$TF_PROV_VER/linux_amd64/$TF_PROV ~/.terraform.d/plugins/registry.terraform.io/ateam/ateam/$TF_PROV_VER/linux_amd64/ateam

# CLI Bash Completion 
source <($CLI_NAME completion bash)
$CLI_NAME completion bash > /etc/bash_completion.d/$CLI_NAME
ateam completion bash > /etc/bash_completion.d/ateam

## Configure JWT token
echo $JWT | $CLI_NAME config auth-token update

