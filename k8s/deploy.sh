curr_dir=$pwd
for dir in $(ls); do
  cd $dir
  echo "⏳ Deploying '$dir' with terraform."  
  terraform init
  terraform plan -auto-approve
  terraform apply -auto-approve
  cd $curr_dir
done