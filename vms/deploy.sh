curr_dir=$PWD
for dir in $(ls -d */); do
  base_name=$(basename $dir)
  cd $base_name
  echo "⏳Deploying vm '$base_name' with OpenTofu."
  tofu init -reconfigure
  tofu plan
  tofu apply -auto-approve
  cd $curr_dir
done