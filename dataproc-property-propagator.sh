#!/bin/bash

# Modify this variable to specify the name of your Dataproc cluster
CLUSTER_NAME=<CLUSTER_NAME>
REGION=us-south1

# Modify this variable to specify the path to the yarn-site.xml file on the worker nodes
YARN_SITE_XML_PATH="/etc/hadoop/conf/yarn-site.xml"

# Get the list of worker nodes in the cluster
WORKER_NODES=$(gcloud dataproc clusters describe --region $REGION $CLUSTER_NAME --format="value(config.workerConfig.instanceNames)")
SECONDARY_NODES=$(gcloud dataproc clusters describe --region $REGION $CLUSTER_NAME --format="value(config.secondaryWorkerConfig.instanceNames)")


# Modify the yarn-site.xml file on each worker node
for node in $WORKER_NODES; do
  echo "Modifying yarn-site.xml on worker node: $node"
  gcloud compute ssh $node -- "sudo sed -i 's/<PROPERTY_TO_MODIFY>/<NEW_VALUE>/g' $YARN_SITE_XML_PATH"
done

# Modify the yarn-site.xml file on each worker node
for node in $SECONDARY_NODES; do
  echo "Modifying yarn-site.xml on worker node: $node"
  gcloud compute ssh $node -- "sudo sed -i 's/<PROPERTY_TO_MODIFY>/<NEW_VALUE>/g' $YARN_SITE_XML_PATH"
done