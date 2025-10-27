curr_dir=$pwd
for dir in $(ls -d */); do
  cd $dir
  echo "⏳Deploying vm '$dir' with terraform."  
  terraform init -backend-config="key=$dir/terraform.tfstate" -reconfigure
  terraform plan
  terraform apply -auto-approve
  cd $curr_dir
done