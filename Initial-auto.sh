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
sudo su
cd /opt

sudo apt-get update
sudo apt-get install python3-pip
wget -P /tmp https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
sh /tmp/Anaconda3-2019.10-Linux-x86_64.sh
source ~/.bashrc
echo "   activate conda "
conda activate
echo "   cloning the git repo "
git clone https://github.com/Pradnya-Koli/Hive-to-bigquery.git

echo " Installing all the required packages :
bash prerequisite-installation.sh

echo "  setup the Hive acid transaction configuration file "
bash auto-conf-setup-incremental.sh

echo "  Restart the hive server "
sudo systemctl restart hive-server2

echo "successfully completed the setup for hive to bigquery migration run the next file start.sh "

cd Hive-to-bigquery
createinsert.sql
