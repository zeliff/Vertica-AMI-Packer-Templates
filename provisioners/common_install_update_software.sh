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

echo 
echo " #### Starting common_install_update_software ####"
echo

OS=`grep ^ID= /etc/os-release | cut -f2 -d= | sed 's/\"//g'`
echo "OS detected: $OS"

echo
echo "*** Remove unwanted packages"
echo 
# VER-46146
yum --color=never erase -y microcode_ctl

case $OS in
    rhel|centos) 
        echo 
        echo "*** Upgrade selected software"
        echo
        yum --color=never update -y cloud-init
        ;;
    amzn)
        #  As of AL 2.0 GA we don't update the OS
        echo
        echo "*** Skipping update of OS packages"
        echo
        #yum --color=never update -y 
        ;;
    *)
        echo "ERROR:   update software.   We shouldn't even be here"
        exit 1
        ;;
esac


echo 
echo "*** Install required software"
echo
echo "   *** Software required for Vertica"
#  See Vertica docs:  Installing Vertica > Before You Install Vertica > Operating System Configuration Task Overview > General Operating System Configuration - Manual Configuration > Support Tools
yum --color=never install -y gdb mcelog sysstat 
#  See Vertica docs:  Installing Vertica > Before You Install Vertica > Operating System Configuration Task Overview > System User Configuration > Package Dependencies
yum --color=never install -y openssh which dialog
#  See Vertica docs:  Installing Vertica > Before You Install Vertica > Operating System Configuration Task Overview > System User Configuration > TZ Environment Variable
yum --color=never update -y tzdata
#  Required for MC cluster provisioning (and raid provisioning)
yum --color=never install -y nmap-ncat mdadm


echo "   *** Software required for AMI creation "
yum --color=never install -y wget sudo yum-versionlock zip unzip

echo "   *** Software required R SDK"

echo "   *** Software required SDK examples"

echo 
echo "*** Update and/or lock kernel"
echo

# Updating for security fixes
# Jiras:  VER-59802, VER-59803
# CVEs:  https://access.redhat.com/errata/RHSA-2018:0007

case $OS in
    centos)
        #yum --color=never update -y kernel kernel-tools-libs
        yum versionlock kernel centos-release
        ;;
    rhel)
        #yum --color=never update -y kernel kernel-tools-libs
        yum versionlock kernel redhat-release-server
        ;;
    amzn)
        #yum --color=never update -y kernel-toos-libs
        yum versionlock add system-release
        ;;
    *)
        echo "ERROR: kernel update/locking: distribution not recognized:  $OS"
        exit 1
        ;;
esac

echo "******"
echo "Kernel:"
echo "******"
uname -a
rpm -q kernel

echo "******"
echo "Version lock list"
echo "******"
yum versionlock list

