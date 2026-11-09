curr_dir=$pwd
for dir in $(ls -d */); do
  base_name=$(basename $dir)
  cd $base_name
  echo "⏳Deploying vm '$base_name' with OpenTofu."
  tofu init -backend-config="key=$base_name/test/terraform.tfstate" -reconfigure
  tofu plan
  tofu apply -auto-approve
  cd $curr_dir
done