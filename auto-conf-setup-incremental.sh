#!/bin/bash

# Define the properties to be added
PROPERTY_1="<property><name> hive.support.concurrency </name><value> true </value></property>"
PROPERTY_2="<property><name> hive.txn.manager </name><value> org.apache.hadoop.hive.ql.lockmgr.DbTxnManager </value></property>"
PROPERTY_3="<property><name> hive.enforce.bucketing </name><value> true value3</value></property>"
PROPERTY_4="<property><name>hive.exec.dynamic.partition.mode </name><value> nostrict </value></property>"
# Use xmlstarlet to add the properties to hive-site.xml
xmlstarlet ed -L -s '//configuration' -t elem -n 'property1' -v "$PROPERTY_1" \
-s '//configuration' -t elem -n 'property2' -v "$PROPERTY_2" \
-s '//configuration' -t elem -n 'property3' -v "$PROPERTY_3" \
-s '//configuration' -t elem -n 'property4' -v "$PROPERTY_4"  /usr/lib/hive/conf/hive-site.xml

cd /usr/lib/spark/conf
cp hive-site.xml hive-site.xml.save
rm hive-site.xml.save

cd /usr/lib/hive/conf
cp hive-site.xml  /usr/lib/spark/conf

sudo systemctl restart hive-server2
# Define properties to be added or modified in spark-conf
declare -A properties=(
  ["spark.sql.extensions"]="com.qubole.spark.hiveacid.HiveAcidAutoConvertExtension"
  ["spark.kryo.registrator"]="com.qubole.spark.hiveacid.util.HiveAcidKyroRegistrator"
  ["spark.sql.hive.hwc.execution.mode"]
  ["spark.hadoop.hive.metastore.uris"]="thrift://demo-hive-to-b1-m:9083"
)

# Iterate over properties and add or modify them in spark-defaults.conf
for property_name in "${!properties[@]}"; do
  property_value="${properties[$property_name]}"
  
  # Check if property already exists in spark-defaults.conf
  if grep -q "^$property_name=" /path/to/spark-defaults.conf; then
    # Modify existing property
    sed -i "s/^$property_name=.*/$property_name=$property_value/" /usr/lib/spark/conf/spark-defaults.conf
  else
    # Add new property at the end of file
    echo "$property_name=$property_value" >> /usr/lib/spark/conf/spark-defaults.conf
  fi
done
