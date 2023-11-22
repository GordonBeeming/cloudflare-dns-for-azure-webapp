cd ..\..\
%TOFU% init -reconfigure -var-file="envs/dev.tfvars" -backend-config="envs/dev.tfbackend"
%TOFU% apply -destroy -auto-approve -input=false -var-file="envs/dev.tfvars"

rem az group delete --resource-group "cloudflare-dev-rg" --yes
cd scripts\dev\