instance_id_array=$( aws ec2 describe-instances --filters "Name=tag:Name,Values=london-summit-demo-nell" "Name=instance-state-name,Values=running" --profile habitat --region us-west-2 | jq -r '.Reservations[].Instances[] | .InstanceId')
echo $instance_id_array

for instance in $instance_id_array
do
  echo "==============="
  echo "here is the instance info"
  aws ec2 describe-instances --instance-ids $instance --profile habitat --region us-west-2  | jq ['.Reservations[].Instances[] | .InstanceId, .InstanceType, .PublicDnsName']
  echo
  echo "here is the password"
  aws ec2 get-password-data --instance-id $instance --priv-launch-key ~/nshamrell2.pem --profile habitat --region us-west-2 | jq .PasswordData
  echo "==============="
  echo 
done