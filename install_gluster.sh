#!/bin/bash
#

install_gluster(){
	dnf install -y centos-release-gluster10
	yum install -y glusterfs-server
	systemctl start   glusterd
	systemctl status  glusterd | cat
}


create_cluster(){
	for octet in 151 152 153 
	do
		gluster peer probe 192.168.7.$octet
	done
}


show_cluster_state(){
	gluster peer status
}


format_and_mount_bricks(){
	for brick_dev in sd{b..f} 
	do
		dev_path=/dev/$brick_dev
		dev_mnt_path=/mnt/$brick_dev
		brick_path=/mnt/$brick_dev/b
		mkfs.xfs -i size=512 $dev_path
		mkdir -p $dev_mnt_path 
		echo "$dev_path $dev_mnt_path xfs defaults 1 2" >> /etc/fstab
	
		# create directory inside mounted brick filesystem 
		mount $dev_path 
		mkdir -p $brick_path

	done
}


main(){
	format_and_mount_bricks
	install_gluster
	# create_cluster - this step should start only on one server
}

main
