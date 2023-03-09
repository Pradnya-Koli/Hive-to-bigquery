CLUSTER_NAME="demo-hive-to-b2"
gcloud dataproc clusters create $CLUSTER_NAME \
--enable-component-gateway \
--region us-central1 \
--zone us-central1-f \
--master-machine-type n2-standard-4 \
--master-boot-disk-size 500 \
--num-workers 2 \
--worker-machine-type n2-standard-4 \
--worker-boot-disk-size 500 \
--image-version 2.0-debian10 \
--project searce-practice-data-analytics \
--service-account=test-demo@searce-practice-data-analytics.iam.gserviceaccount.com

gcloud compute ssh demo-hive-to-b2-m --project=searce-practice-data-analytics --zone=us-central1-f
sudo su
cd /opt
git clone https://github.com/Pradnya-Koli/Hive-to-bigquery.git
bash prerequisite-installation.sh
bash auto-conf-setup-incremental.sh

