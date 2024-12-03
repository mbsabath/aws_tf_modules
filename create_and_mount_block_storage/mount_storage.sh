real_path=`readlink -f {{ mountPath }}`
if [[ -z `echo $real_path | grep '/dev/'` ]]; then
  real_path=/dev/$real_path
fi

## Check if we need to format the device
if [[ -z `sudo file -s $real_path | grep 'XFS'` ]]; then
  sudo mkfs -t xfs $real_path
fi


## Mount the device
sudo mkdir {{ mountTarget }}
sudo mount $real_path {{ mountTarget }}

sudo touch /{{ completionFlag }}
