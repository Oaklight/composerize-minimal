# 最小化的 Composerize Docker 镜像

[English](./README_en.md)

该项目提供了一个用于托管 [ `composerize` ](https://www.composerize.com/) 、 [ `decomposerize` ](https://www.decomposerize.com/) 和 [ `composeverter` ](https://www.composeverter.com/) 网站的最小化 Docker 镜像。该镜像通过多阶段 Docker 构建过程构建，并利用最小的基础镜像来提供静态文件服务。

## 特性

* **多阶段构建**：分别构建 `composerize`、`decomposerize` 和 `composeverter` 的静态网站。
* **最小化镜像体积**：使用 `lipanski/docker-static-website` 作为最终的基础镜像，生成的镜像体积仅为 **~7MB**（包括静态文件的大小）。
* **易于使用**：通过提供的 `Makefile` 或 `build.sh` 脚本自动完成构建过程。

## 仓库结构

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

4 个目录，5 个文件
```

## 生产环境 Docker Compose

要使用 [Docker Hub](https://hub.docker.com/r/oaklight/composerize) 上预构建的 `oaklight/composerize` 镜像，请使用 [ `compose.yaml` ](compose.yaml) 文件：

```bash
docker compose -f compose.yaml up
```

访问以下网站：
* Composerize: http://localhost:8080
* Decomposerize: http://localhost:8080/decomposerize
* Composeverter: http://localhost:8080/composeverter

## 自定义 / 本地构建

要对 Docker 镜像或静态网站进行自定义修改，请修改 `Dockerfile` 或相应的子模块（ `composerize` 、 `decomposerize` 、 `composeverter` ）。然后使用以下命令构建：

```bash
make build
```

## 致谢

该项目灵感来源于：
* [alcapone1933/docker-composerize](https://github.com/alcapone1933/docker-composerize)
* [lipanski.com - 最小的静态网站 Docker 镜像](https://lipanski.com/posts/smallest-docker-image-static-website)

特别感谢：
* [**sharevb**](https://github.com/sharevb) 持续维护 [composerize/composerize](https://github.com/composerize/composerize) 仓库！
