#!/bin/bash

# Variables
BUILD_NAME=composerize-minimal-composerize
IMAGE_NAME="oaklight/composerize"
IMAGE_TAG="latest"

# Pull the latest submodules
echo "Pulling the latest submodules..."
git submodule update --init --recursive --remote

# Build the Docker image
echo "Building the Docker image..."
docker compose -f compose.dev.yaml build

# Tag and push the Docker image to Docker Hub
echo "Tagging and pushing the Docker image to Docker Hub..."
docker tag ${BUILD_NAME} ${IMAGE_NAME}:${IMAGE_TAG}
docker push ${IMAGE_NAME}:${IMAGE_TAG}

echo "Done!"
