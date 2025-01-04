# Makefile for minimal-composerize

# Variables
IMAGE_NAME = oaklight/composerize
IMAGE_TAG = latest
PLATFORMS = linux/amd64,linux/arm64,linux/arm/v7

# Default target
all: build

# Pull the latest submodules
pull-submodules:
	git submodule update --init --recursive --remote

# Build the Docker image for multiple architectures and push to Docker Hub
build: pull-submodules
	@echo "Building Docker image for platforms: $(PLATFORMS)"
	-docker buildx rm multiarch-builder 2>/dev/null || true
	docker buildx create --use --name multiarch-builder || true
	docker buildx build --platform $(PLATFORMS) -t $(IMAGE_NAME):$(IMAGE_TAG) --push .

# Build the Docker image for the local architecture (development)
build-local: pull-submodules
	@echo "Building Docker image for local architecture"
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

# Clean up unused Docker resources and buildx builder
clean:
	@echo "Cleaning up unused Docker resources and buildx builder"
	docker system prune -f
	docker buildx rm multiarch-builder || true

# Run the Docker container (local development)
run: build-local
	@echo "Running Docker container locally"
	docker run -d -p 8080:80 --name composerize $(IMAGE_NAME):$(IMAGE_TAG)

# Stop the Docker container (local development)
stop:
	@echo "Stopping Docker container"
	-docker stop composerize
	-docker rm composerize

# Help message
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  pull-submodules  Pull the latest submodules"
	@echo "  build            Build the Docker image for multiple architectures and push to Docker Hub"
	@echo "  build-local      Build the Docker image for the local architecture (development)"
	@echo "  clean            Clean up unused Docker resources and buildx builder"
	@echo "  run              Run the Docker container locally (development)"
	@echo "  stop             Stop the Docker container (development)"
	@echo "  help             Show this help message"

.PHONY: all pull-submodules build build-local clean run stop help