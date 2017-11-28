#!/bin/bash
################################################################################
# ref_link_cp_btrfs.sh
################################################################################
# performs aged grep test on btrfs clones made with cp --ref-link
#
# usage:
#
################################################################################

AGED_PATH=$1
AGED_BLKDEV=$2
UNAGED_PATH=$3
UNAGED_BLKDEV=$4

# remount aged and time a recursive grep
umount $AGED_PATH &>> log.txt
mount $AGED_BLKDEV $AGED_PATH &>> log.txt
AGED="$(TIMEFORMAT='%3R'; time (grep -r "t26EdaovJD" $AGED_PATH) 2>&1)"
SIZE="$(du -s $AGED_PATH | awk '{print $1}')"

# return the size and times
echo "$SIZE $AGED
