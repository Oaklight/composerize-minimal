# Minimal Composerize Docker Image

[中文版](./README.md)

This project provides a minimal Docker image for serving the [ `composerize` ](https://www.composerize.com/) 、 [ `decomposerize` ](https://www.decomposerize.com/) and [ `composeverter` ](https://www.composeverter.com/) websites. The image is built using a multi-stage Docker build process and leverages the smallest possible base image for serving static files.

## Features

* **Multi-stage build**: Separately builds the static websites for `composerize`,                `decomposerize`, and `composeverter`.
* **Minimal image size**: Uses `lipanski/docker-static-website` as the final base image, resulting in an image size of just **~7MB** (including the size of the static files).
* **Easy to use**: Automates the build process using the provided `Makefile` or `build.sh` script.

## Repository Structure

```
$ tree -L 2 .
.
├── build.sh
├── compose.dev.yaml
├── compose.yaml
├── Dockerfile
├── Makefile
├── README.md
└── submodules
    ├── composerize
    ├── composeverter
    └── decomposerize

4 directories, 6 files
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
./build.sh
```

or

```bash
make build
```

## Acknowledgments

This project is inspired by:
* [alcapone1933/docker-composerize](https://github.com/alcapone1933/docker-composerize)
* [lipanski.com - Smallest Docker Image for a Static Website](https://lipanski.com/posts/smallest-docker-image-static-website)

Special thanks to:
* [**sharevb**](https://github.com/sharevb) for maintaining the repositories for [composerize/composerize](https://github.com/composerize/composerize).
