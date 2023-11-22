cd ..\..\
%TOFU% init -reconfigure -var-file="envs/dev2.tfvars" -backend-config="envs/dev2.tfbackend"
%TOFU% apply -destroy -auto-approve -input=false -var-file="envs/dev2.tfvars"

rem az group delete --resource-group "cloudflare-dev-rg" --yes
cd scripts\dev2\