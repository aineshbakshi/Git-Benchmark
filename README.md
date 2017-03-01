# Git-Benchmark
Git Benchmark for File System Aging

###How to run the test:

1. cp defconfig.sh config.sh
2. Edit the following parameters in config.sh:
	- user=$username:$username
	- Edit both aged) and clean)  
	- partition=$partitionname
	- fs_type=$filesystem (ext4, xfs, zfs, btrfs, betrfs)
	- For betrfs edit module=$path_to_ftfs.ko
3. Run "sudo ./first_time_setup.sh" if the test hasn't been run before. This will install the dependencies and filesystems.
4. Run "sudo -E python test.py"

 
