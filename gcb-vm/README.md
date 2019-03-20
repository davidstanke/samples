# Use Cloud Build to bake a GCE VM

### Running Packer locally:
```
./mvnw package
packer build \
    -var region=us-central1 \
    -var source_image_family=ubuntu-1604-lts \
    -var machine_type=n1-standard-1 \
    -var zone=us-central1-c \
    -var project_id=$(gcloud config get-value project 2> /dev/null) \
    -var image_name=test-$(date +%s) \
    -var jar_file=target/hello-gcb-0.0.1-SNAPSHOT.jar \
    packer.json
```