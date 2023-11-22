cd ..\..\
%TOFU% init -reconfigure -var-file="envs/dev2.tfvars" -backend-config="envs/dev2.tfbackend" %*
cd scripts\dev2\