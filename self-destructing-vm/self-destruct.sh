#!/bin/sh
echo "self-destruct sequence initiated..."
gcloud compute instances delete $(hostname) --zone \
$(curl -H Metadata-Flavor:Google http://metadata.google.internal/computeMetadata/v1/instance/zone|cut -d/ -f4) -q