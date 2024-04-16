#!/bin/bash

# Define your Kubernetes namespace
NAMESPACE="MyProject"

# Function to apply manifest files
apply_manifests() {
    kubectl apply -f $1 -n $NAMESPACE
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

    echo "Deployment completed successfully!"
}

# Run main function
main
