#!/bin/bash

# Current folder
SRC=$(dirname $(readlink -f $0))

# Check if docker is available
if ! command -v docker &> /dev/null; then
    echo "Error: docker is not installed or not in PATH"
    echo "Please install 'docker' before continuing"
    exit 1
fi

if [ ! -d pi-gen ]; then
  ./clone.sh
else
  echo "pi-gen already exists, building with that directory..."
fi

if [ ! -f pi-gen/build-docker.sh ]; then
  echo "Error: pi-gen doesn't have a build-docker.sh script!"
  echo "Has this file been moved?"
  exit 1
fi

cd pi-gen
bash $SRC/prepare.sh
echo "Done preparing 'pi-gen', ready for build now."

echo "Starting pi-gen build..."
bash build.sh
echo ""
echo "pi-gen/build-docker.sh complete!"
echo ""
echo "Done!"