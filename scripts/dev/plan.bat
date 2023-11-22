cd ..\..\
%TOFU% plan -input=false -var-file="envs/dev.tfvars" -out="envs/dev.tfplan" %*
cd scripts\dev\