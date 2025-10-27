curr_dir=$pwd
for dir in $(ls -d */); do
  base_name=$(basename $dir)
  cd $base_name
  echo "⏳Deploying k8s '$base_name' with terraform."  
  terraform init -backend-config="key=$base_name/test/terraform.tfstate" -reconfigure
  terraform plan
  terraform apply -auto-approve
  cd $curr_dir
done