cd ..\..\
%TOFU% plan -input=false -var-file="envs/dev2.tfvars" -out="envs/dev2.tfplan" %*
cd scripts\dev2\