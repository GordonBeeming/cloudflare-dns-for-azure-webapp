cd ..\..\
%TOFU% init -reconfigure -var-file="envs/dev.tfvars" -backend-config="envs/dev.tfbackend" %*
cd scripts\dev\