# Makefile for minimal-composerize

# Variables
BUILD_NAME = composerize-minimal-composerize
IMAGE_NAME = oaklight/composerize
IMAGE_TAG = latest

# Default target
all: build

# Pull the latest submodules
pull-submodules:
	git submodule update --init --recursive --remote

# Build the Docker image
build: pull-submodules
	docker compose -f compose.dev.yaml build

# Push the Docker image to Docker Hub
push: build
	docker tag $(BUILD_NAME) $(IMAGE_NAME):$(IMAGE_TAG)
	docker push $(IMAGE_NAME):$(IMAGE_TAG)

# Clean up unused Docker resources
clean:
	docker system prune -f

# Run the Docker container
run: build
	docker compose -f compose.dev.yaml up

# Help message
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  pull-submodules  Pull the latest submodules"
	@echo "  build            Build the Docker image"
	@echo "  push             Push the Docker image to Docker Hub"
	@echo "  clean            Clean up unused Docker resources"
	@echo "  run              Run the Docker container"
	@echo "  help             Show this help message"

.PHONY: all pull-submodules build push clean run help