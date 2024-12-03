# Mounted Block Storage

This module is used to mount a block storage device to a specific directory on the filesystem.
It creates a directory at the specified path if it does not exist and mounts the block storage device to it. 

This creates the EBS volume, attaches it to the instance, formats it, mounts it, and adds an entry to the `/etc/fstab` file to ensure that the volume is mounted after a reboot. It uses SSM documents
to execute the commands on the instance and creats a "disk_mounted" file in the root directory of the instance when mounting is successful.

Needed as a workaround as the path that the block storage is mounted to is not persistent across reboots/is not known until after the block storage is created and attached to the instance.