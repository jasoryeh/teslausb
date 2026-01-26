#!/bin/bash

if [ -d pi-gen ]; then
  echo "pi-gen already exists! To re-configure, run 'rm -r pi-gen' first to re-clone.";
  exit 1
fi

git clone https://github.com/RPi-Distro/pi-gen.git pi-gen

echo "Clone complete."