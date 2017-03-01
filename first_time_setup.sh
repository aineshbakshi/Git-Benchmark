#!/bin/bash

# This script makes sure the system has the requisite programs, especially a
# late enough version of git. It also downloads and untars the necessary linux
# repo.

set -x

apt-get update > /dev/null

# script dependencies
apt-get -y install blktrace > /dev/null

# git dependencies
apt-get -y install make git autoconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev > /dev/null

# filesystems
apt-get -y install xfsprogs f2fs-tools btrfs-tools > /dev/null

# zfs
sudo apt-get -y install build-essential gawk alien fakeroot gdebi libtool linux-headers-$(uname -r) &> /dev/null
sudo apt-get -y install zlib1g-dev uuid-dev libattr1-dev libblkid-dev libselinux-dev libudev-dev parted lsscsi wget ksh libtool &> /dev/null

wget https://github.com/zfsonlinux/zfs/releases/download/zfs-0.6.5.9/spl-0.6.5.9.tar.gz
wget https://github.com/zfsonlinux/zfs/releases/download/zfs-0.6.5.9/zfs-0.6.5.9.tar.gz

tar -xzf spl-0.6.5.9.tar.gz
tar -xzf zfs-0.6.5.9.tar.gz

cd spl-0.6.5.9.tar.gz
./configure

make deb-utils deb-kmod
sudo dpkg -i \
	kmod-spl-devel_0.6.5.9-1_amd64.deb \
	kmod-spl-devel-3.11.10_0.6.5.9-1_amd64.deb \
	kmod-spl-3.11.10_0.6.5.8-1_amd64.deb \
	spl_0.6.5.8-1_amd64.deb

cd ../zfs-0.6.5.9.tar.gz
./configure

make deb-utils deb-kmod

cd ..
sudo dpkg -i \
	spl-0.6.5.8/spl_0.6.5.8-1_amd64.deb \
	spl-0.6.5.8/kmod-spl-3.11.10_0.6.5.8-1_amd64.deb \
	zfs-0.6.5.8/zfs_0.6.5.8-1_amd64.deb \
	zfs-0.6.5.8/kmod-zfs-3.11.10_0.6.5.8-1_amd64.deb \
	zfs-0.6.5.8/libnvpair1_0.6.5.8-1_amd64.deb \
	zfs-0.6.5.8/libuutil1_0.6.5.8-1_amd64.deb \
	zfs-0.6.5.8/libzfs2_0.6.5.8-1_amd64.deb \
	zfs-0.6.5.8/libzpool2_0.6.5.8-1_amd64.deb



#git clone https://github.com/zfsonlinux/spl &> /dev/null
#git clone https://github.com/zfsonlinux/zfs &> /dev/null
#cd spl
#git checkout master
#sh autogen.sh
#./configure
#make -s -j$(nproc)
#cd ../zfs
#git checkout master
#sh autogen.sh
#./configure
#make -s -j$(nproc)
#./scripts/zfs-helpers.sh -i
#./scripts/zfs.sh


git clone https://github.com/git/git &> /dev/null
cd git
make configure > /dev/null
./configure --prefix=/usr > /dev/null
make all > /dev/null
make install > /dev/null
git config --global gc.autodetach False
git config --global gc.auto 0
git config --global uploadpack.allowReachableSHA1InWant True
git config --global user.name Ainesh
git config --global user.email ainesh.bakshi@rutgers.edu
