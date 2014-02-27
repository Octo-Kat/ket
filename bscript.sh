#!/bin/bash
## Build Automation Scripts - Kernel Edition
##
## Copywrite 2014 - Donald Hoskins <grommish@gmail.com>
## on behalf of Team Octos et al.

# Figure out where we are, so we can get back
CWD=$(pwd)
# Set the Revision
REV="0.1"
# Kernel Out Dir - This Directory Hold the Updater Scripts and Structure
KOUT="/home/donald/gkernel"
UPDATER="vendor/oct/tools/Octos_Template.zip"

PUSH=$1
BSPEED=$2
: ${PUSH:=false}
: ${BSPEED:="21"}
BVARIANT=$3
LOKI=$4
: ${LOKI}:=false}

source build/envsetup.sh
source ket/credentials.sh

echo "Setting Lunch Menu to ${BVARIANT}"
lunch oct_${BVARIANT}-userdebug

## Clean Up Previous Builds as well as old module files
make installclean && rm -rf ${KOUT}

## Current Build Date
BDATE=`date +%m-%d`

if [ $1 = "y" ]; then
PUSH=true
else
PUSH=false
fi

if [[ $4 = "y" ]]; then
LOKI=true
else
LOKI=false
fi


if [ ! -d "${COPY_DIR}/${BDATE}" ]; then
	echo "Creating directory for ${COPY_DIR}/${BDATE}"
	mkdir -p ${COPY_DIR}/${BDATE}
fi

echo "Starting brunch with ${BSPEED} threads for ${COPY_DIR}"
if ${PUSH}; then
echo "Pushing to Remote after build!"
fi
# Build command
mka -j${BSPEED} bootimage

# Time to decide which updater template to use.
if ${LOKI}; then
echo "Loki Doki with my Loki Poki Stick"
UPDATER="vendor/oct/tools/Octos_Template_Loki.zip"
fi

echo "Using ${UPDATER} - ${UPDATER##*/}"
mkdir -p ${KOUT}
cp ${UPDATER} ${KOUT}
cd ${KOUT} && unzip ${UPDATER##*/} && rm -rf *.zip

echo "Moving boot.img to ${KOUT}"
cp -f ${OUT}/boot.img ${KOUT}
echo "Moving modules to ${KOUT}/system/lib/modules/"
cp -f ${OUT}/system/lib/modules/*.ko ${KOUT}/system/lib/modules/
echo "Ziping Flashable"
cd ${KOUT} && zip -r GKernel-${BDATE}-${BVARIANT}-${REV}.zip * && cd ${CWD}
echo "Moving Flashable to Copy Box"
cp ${KOUT}/*.zip ${COPY_DIR}/${BDATE}
