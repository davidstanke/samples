# Use Cloud Build to bake and deploy a GCE VM

### Running Packer locally:
`packer build -var region=us-central1 -var source_image_family=ubuntu-1604-lts -var machine_type=n1-standard-1 -var zone=us-central1-c -var project_id=$(gcloud config get-value project 2> /dev/null) -var image_name=test-$(date +%s) packer.json`