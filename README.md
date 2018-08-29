This repository contains the packer template for creating the Vertica Server AMI.
# Notice
(c) Copyright 2017 EntIT Software LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use the software in this repository except in 
compliance with the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# Overview
This repository contains a set of packer templates and provisioning scripts which are used to create a Vertica server AMI.  These templates support AMIs based upon Red Hat Enterprise Linux 7.4, CentOS 7.4, and Amazon Linux 2.0.  The templates also use the us-east-1 region.  This can be changed by editting the ```server_ami.json``` file.

# Limitations

   * These templates are tailored for use with Vertica version 9.0.0 and later.

# Preliminaries

1.  Install [Packer](www.packer.io) on your host.  
2.  Create a ```aws_credentials.json``` file from the example, substituing your own AWS credentials.
3.  Download the Vertica server rpm and the Vertica R Language extension rpm to a directory named 'rpms'

# Using Packer to Create the Vertica AMI

1. Run ``` bin/create_server_ami.sh -o <OS>```.   This script optinally takes one of two parameters:  -b \<build number\> or -n \<AMI name\>


