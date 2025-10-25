curr_dir=$pwd
for dir in $(ls -d */); do
  cd $dir
  echo "⏳Deploying k8s '$dir' with terraform."  
  terraform init
  terraform plan
  terraform apply -auto-approve
  cd $curr_dir
done