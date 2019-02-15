# Make a GCE VM that self-destructs

TODO: bake this into a VM image and put it in a public place ('doingdevops' prject)

1. create it:
```
gcloud compute instances create \
  self-destruct-01 \
  --zone=us-central1-c \
  --image=ubuntu-1604-xenial-v20190212 --image-project=ubuntu-os-cloud --boot-disk-size=200GB \
  --scopes=https://www.googleapis.com/auth/compute,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/trace.append,https://www.googleapis.com/auth/devstorage.read_only \
  --metadata SELF_DESTRUCT_INTERVAL_MINUTES=2 \
  --metadata-from-file startup-script=self-destruct.sh
```

1. self-destruct script: self-destruct.sh
(place at `/` and `chmod 755` it)
```
gcloud compute scp ./self-destruct.sh root@self-destruct-01:/
gcloud compute ssh root@self-destruct-01 --command 'chmod 755 /self-destruct.sh'
```
1. schedule the self-destruct script to run 5 min after boot
```
gcloud compute ssh root@self-destruct-01 --command 'export SELF_DESTRUCT="1m"'
gcloud compute ssh root@self-destruct-01 --command '(crontab -l 2>/dev/null; echo "@reboot sleep $SELF_DESTRUCT && /self-destruct.sh") | crontab -'
gcloud compute ssh root@self-destruct-01 --command 'reboot'
```