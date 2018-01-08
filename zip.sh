#!/bin/bash



#@@@@@@@@@@@@@@@@ AnyKernel2 @@@@@@@@@@@@@@@@@@@@@@#
# Environment variables for flashable zip creation (AnyKernel2)
ANYKERNEL=$PWD/zip/anykernel;
EXT=$PWD/zip;
BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'

##sesuaikan lokasi boot arm/arm64 dan nama zImage
KERNELPATH=arch/arm64/boot;
ZIMAGE=Image.gz-dtb

# NOTE: Generate value for build date before creating zip in order to get accurate value
DATE=$(date +"%Y%m%d-%H%M");

#ubah nama device masing-masing (ido)
ZIP=Redsun$DATE.zip;

# Create flashable zip
if [ -f $KERNELPATH/$ZIMAGE ]; then
echo "Create Flashable zip Anykernel2";
cp -f $KERNELPATH/$ZIMAGE $ANYKERNEL/$ZIMAGE;
cd $EXT/;
zip -qr9 $ZIP .;
cd ../..;

# The whole process is now complete. Now do some touches...
# move ZIP to /root
mv -f $EXT/$ZIP /root/mido/$ZIP;

#Then doing cleanup
echo "Doing post-cleanup...";
rm -rf arch/arm64/boot/dtb;
rm -rf $ANYKERNEL/Image.gz-dtb;
rm -rf $ANYKERNEL/dtb;
rm -rf drivers/platform/msm/ipa/ipa_common
echo "Done.";

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))

echo "#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#"
echo "                                        "
echo "     KERNEL BUILD IS SUCCESSFUL         "
echo "                                        "
echo " $ZIP                 "
echo "                                        "
echo -e "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
echo "#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#"
else
echo "#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#"
echo "                                        "
echo "     ERROR !!! ERROR !!! ERROR !!!      "
echo "                                        "
echo "          DON'T GIVE UP @_@             "
echo "                                        "
echo -e "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
echo "#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#"
fi
exit
