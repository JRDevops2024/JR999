#!/bin/bash

# Define your Kubernetes namespace
NAMESPACE="MyProject"

# Function to apply manifest files
apply_manifests() {
  kubectl apply -f $1 -n $NAMESPACE
}

# Function to log resource metrics
log_metrics() {
  # Log pod metrics (CPU, memory)
  kubectl get pods -n $NAMESPACE -o custom-columns=NAME:.metadata.name,CPU:.status.containerStatuses[0].resources.requests.cpu,MEMORY:.status.containerStatuses[0].resources.requests.memory -l app=<your-app-label> &> deployment_metrics.log

  # Optionally, log node metrics (CPU, memory)
  # kubectl top nodes -o custom-columns=NAME:.metadata.name,CPU:.usage.cpu,MEMORY:.usage.memory &> node_metrics.log

  # You can customize the metrics and output format as needed
}

# Main function
main() {
  # Check if all files exist
  if [ ! -f "deploy.yaml" ] || [ ! -f "service.yaml" ] || [ ! -f "ingress.yaml" ]; then
    echo "One or more manifest files are missing!"
    exit 1
  fi

  # Apply each manifest file
  apply_manifests "deploy.yaml"
  apply_manifests "service.yaml"
  apply_manifests "ingress.yaml"

  # Log metrics after deployment
  log_metrics

  echo "Deployment completed successfully! Metrics logged to deployment_metrics.log"
}

# Run main function
main
