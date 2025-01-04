# Stage 1: Build composerize
FROM --platform=linux/amd64 node:current-alpine3.21 AS composerize
RUN apk add --update --no-cache npm git make jq bash tini && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /opt/composerize
WORKDIR /opt/composerize
COPY submodules/composerize /opt/composerize
WORKDIR /opt/composerize/packages/composerize-website

# Update deprecated dependencies in composerize
RUN sed -i "s,https://www.composerize.com,/,g" package.json && \
    sed -i "s,https://decomposerize.com,/decomposerize,g" src/components/Entry.js && \
    sed -i "s,http://composeverter.com,/composeverter,g" src/components/Entry.js && \
    npm install --legacy-peer-deps && \
    make build

# Stage 2: Build decomposerize
FROM --platform=linux/amd64 node:current-alpine3.21 AS decomposerize
RUN apk add --update --no-cache npm git make jq bash tini && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /opt/decomposerize
WORKDIR /opt/decomposerize
COPY submodules/decomposerize /opt/decomposerize
WORKDIR /opt/decomposerize/packages/decomposerize-website

# Update deprecated dependencies in decomposerize
RUN sed -i "s,https://www.decomposerize.com,/decomposerize,g" package.json && \
    sed -i "s,https://composerize.com,/,g" src/components/Entry.js && \
    sed -i "s,http://composeverter.com,/composeverter,g" src/components/Entry.js && \
    npm install --legacy-peer-deps && \
    make build

# Stage 3: Build composeverter
FROM --platform=linux/amd64 node:current-alpine3.21 AS composeverter
RUN apk add --update --no-cache npm git make jq bash tini && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /opt/composeverter
WORKDIR /opt/composeverter
COPY submodules/composeverter /opt/composeverter
WORKDIR /opt/composeverter/packages/composeverter-website

# Update deprecated dependencies in composeverter
RUN sed -i "s,https://www.composeverter.com,/composeverter,g" package.json && \
    sed -i "s,https://composerize.com,/,g" src/components/Entry.js && \
    sed -i "s,https://decomposerize.com,/decomposerize,g" src/components/Entry.js && \
    npm install --legacy-peer-deps && \
    make build

# Stage 4: Final minimal multi-architecture image with lipanski/docker-static-website
FROM --platform=$BUILDPLATFORM lipanski/docker-static-website:latest

# Copy built static files from previous stages
COPY --from=composerize /opt/composerize/packages/composerize-website/build/ /var/www/
COPY --from=decomposerize /opt/decomposerize/packages/decomposerize-website/build/ /var/www/decomposerize/
COPY --from=composeverter /opt/composeverter/packages/composeverter-website/build/ /var/www/composeverter/

# Expose port 80
EXPOSE 80

# Start the BusyBox httpd server
CMD ["/busybox-httpd", "-f", "-v", "-p", "80", "-h", "/var/www"]