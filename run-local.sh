#!/bin/sh

# Use repo2docker to build the image from the workspace
docker run  \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "`pwd`/data/workspace:/WholeTale/workspace" \
  -v "`pwd`/metadata/environment.json:/WholeTale/workspace/.wholetale/environment.json" \
  --privileged=true \
  -e DOCKER_HOST=unix:///var/run/docker.sock \
  wholetale/repo2docker_wholetale:v0.8 \
  jupyter-repo2docker \
    --config=/wholetale/repo2docker_config.py \
    --target-repo-dir=/WholeTale/workspace \
    --user-id=1000 --user-name=rstudio \
    --no-clean --no-run --debug \
    --image-name wholetale/tale_5db883ba7bf5ca3bf549cab3 \
    /WholeTale/workspace

docker run --rm \
    -v "`pwd`:/bag" \
    -ti wholetale/repo2docker_wholetale:v0.8 bdbag --resolve-fetch all /bag

echo "========================================================================"
echo " Open your browser and go to: http://localhost:8787/ "
echo "========================================================================"

# Run the built image
docker run -p 8787:8787 \
  -v "`pwd`/data/data:/WholeTale/data" \
  -v "`pwd`/data/workspace:/WholeTale/workspace" \
  wholetale/tale_5db883ba7bf5ca3bf549cab3 /start.sh

