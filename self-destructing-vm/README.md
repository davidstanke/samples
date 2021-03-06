# Make a GCE VM that self-destructs

1. clone this repo (you'll need the `self-destruct.sh` script present in this folder)

2. create the vm:
```
gcloud compute instances create \
  self-destruct-01 \
  --zone=us-central1-c \
  --image-family=ubuntu-1804-lts --image-project=ubuntu-os-cloud --boot-disk-size=200GB \
  --scopes=https://www.googleapis.com/auth/compute,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/trace.append,https://www.googleapis.com/auth/devstorage.read_only \
  --metadata SELF_DESTRUCT_INTERVAL_MINUTES=2 \
  --metadata-from-file startup-script=self-destruct.sh
```
...it should self-delete in 2 minutes