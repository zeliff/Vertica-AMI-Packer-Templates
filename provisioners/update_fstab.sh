#!/bin/bash -e

#!/bin/sh -ex

# Copyright 2017 EntIT Software LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Add the mountpoints for the swapfile and /vertica/data to /etc/fstab

echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
echo "/dev/xvdb1 /vertica/data ext4 defaults,noatime 0 0" >> /etc/fstab
mount /vertica/data
echo
echo checking mounts:
echo
mount 
echo
echo /etc/fstab
echo
cat /etc/fstab


