#!/bin/bash
################################################################################
# grep_ext4.sh
################################################################################
# performs aged and unaged grep tests on ext4
#
# usage:
# ./grep_ext4.sh path_to_aged aged_blk_device path_to_unaged unaged_blk_device
################################################################################

AGED_PATH=$1
AGED_BLKDEV=$2
UNAGED_PATH=$3
UNAGED_BLKDEV=$4

# remount aged and time a recursive grep
umount $AGED_PATH &>> log.txt
mount $AGED_BLKDEV $AGED_PATH &>> log.txt
AGED="$(time -f "%e" grep -r "t26EdaovJD" $AGED_PATH)"
SIZE="$(du -s $AGED_PATH)"

# create a new ext4 filesystem, mount it, time a recursive grep and dismount it
mkfs.ext4 $UNAGED_BLKDEV &>> log.txt
mount $UNAGED_BLKDEV $UNAGED_PATH &>> log.txt
UNAGED="$(time -f "%e" grep -r "t26EdaovJD" $UNAGED_PATH)"
umount $UNAGED_PATH &>> log.txt

# return the size and times
echo "$SIZE $AGED $UNAGED"



