# Minimal Composerize Docker Image

[中文版](./README_zh.md)

[![Docker Image](https://img.shields.io/docker/v/oaklight/composerize?label=docker%20image&sort=date&color=green)](https://hub.docker.com/r/oaklight/composerize)
[![Docker Image Size](https://img.shields.io/docker/image-size/oaklight/composerize/latest?color=green)](https://hub.docker.com/r/oaklight/composerize)
[![Docker Updated](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Foaklight%2Fcomposerize&query=last_updated&label=docker%20pushed&color=green)](https://hub.docker.com/r/oaklight/composerize)

[![composerize](https://img.shields.io/github/last-commit/composerize/composerize?label=composerize%20upstream&color=green)](https://github.com/composerize/composerize)
[![decomposerize](https://img.shields.io/github/last-commit/composerize/decomposerize?label=decomposerize%20upstream&color=green)](https://github.com/composerize/decomposerize)
[![composeverter](https://img.shields.io/github/last-commit/outilslibre/composeverter?label=composeverter%20upstream&color=green)](https://github.com/outilslibre/composeverter)

This project provides a minimal Docker image for serving the [ `composerize` ](https://www.composerize.com/) 、 [ `decomposerize` ](https://www.decomposerize.com/) and [ `composeverter` ](https://www.composeverter.com/) websites. The image is built using a multi-stage Docker build process and leverages the smallest possible base image for serving static files.

## Features

* **Multi-stage build**: Separately builds the static websites for `composerize`,                  `decomposerize`, and `composeverter`.
* **Minimal image size**: Uses `lipanski/docker-static-website` as the final base image, resulting in an image size of just **~7MB** (including the size of the static files).
* **Easy to use**: Automates the build process using the provided `Makefile` or `build.sh` script.
* **Multi-arch support**: now supporting `linux/amd64`, `linux/arm64/v8`, and `linux/arm/v7` docker images.


## Repository Structure

```
$ tree -L 2 .
.
├── compose.dev.yaml
├── compose.yaml
├── Dockerfile
├── Makefile
├── README.md
└── submodules
    ├── composerize
    ├── composeverter
    └── decomposerize

4 directories, 5 files
```

## Production Docker Compose

To use the pre-built `oaklight/composerize` image from [Docker Hub](https://hub.docker.com/r/oaklight/composerize), use the [ `compose.yaml` ](compose.yaml) file:

```bash
docker compose -f compose.yaml up
```

Access the websites:
* Composerize: http://localhost:8080
* Decomposerize: http://localhost:8080/decomposerize
* Composeverter: http://localhost:8080/composeverter

## Customization / Build Locally

To make customizations to the Docker image or the static websites, modify the `Dockerfile` or the respective submodules ( `composerize` , `decomposerize` , `composeverter` ). Then, build using:

```bash
make build
```

## Acknowledgments

This project is inspired by:
* [alcapone1933/docker-composerize](https://github.com/alcapone1933/docker-composerize)
* [lipanski.com - Smallest Docker Image for a Static Website](https://lipanski.com/posts/smallest-docker-image-static-website)

Special thanks to:
* [**sharevb**](https://github.com/sharevb) for maintaining the repositories for [composerize/composerize](https://github.com/composerize/composerize).
