echo " Creating the Dataproc Clusters"
gcloud dataproc clusters create demo-hive-to-b2 \
--enable-component-gateway \
--region us-central1  \
--zone us-central1-f  \
--master-machine-type n2-standard-4 \
--master-boot-disk-size 500 \
--num-workers 2 \
--worker-machine-type n2-standard-4 \
--worker-boot-disk-size 500 \
--image-version 2.0-debian10 \
--project searce-practice-data-analytics \
--service-account=test-demo@searce-practice-data-analytics.iam.gserviceaccount.com
echo "Connecting To compute ssh "
gcloud compute ssh demo-hive-to-b2-m --project=searce-practice-data-analytics --zone=us-central1-f
