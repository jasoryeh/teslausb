#!/bin/bash -eu

# The current pi-gen-sources folder
SRC=$(dirname $(readlink -f $0))
# The RPi-Distro/pi-gen folder
DEST=$(readlink -f .)

# Quick check to ensure we're in the right place
if [[ "$DEST" != */pi-gen ]]
then
  echo "$0 should be called from the RPi-Distro pi-gen folder"
  exit 1
fi

# 1. Copy the pi-gen-config to the pi-gen folder
cp "$SRC/pi-gen-config" config
# 2. Adjust stage-2 (lite) build options,
#   - disable exporting so it doesn't stop at raspberry build
#   - disable userconf-pi in 00-packages stage at export
rm -rf stage2/EXPORT_NOOBS stage2/EXPORT_IMAGE export-image/01-user-rename/00-packages
# 3. Create TeslaUSB stage
mkdir -p stage_teslausb
# 4. Enable image export at our stage
touch stage_teslausb/EXPORT_IMAGE
# 5. Copy stage2 to our stage
cp stage2/prerun.sh stage_teslausb/prerun.sh
# 6. 00-teslausb-tweaks as a stage into pi-gen
cp -r "$SRC/00-teslausb-tweaks" stage_teslausb

# Done.
echo 'Build config set. Now use "./build.sh" or "./build-docker.sh" to build the TeslaUSB image.'


