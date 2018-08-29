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

#OS=`grep ^ID= /etc/os-release | cut -f2 -d= | sed 's/\"//g'`

cat >> /etc/security/limits.conf  << EOF
@verticadba - nice 0
@verticadba - as unlimited
@verticadba - nofile 65536
@verticadba - fsize unlimited
@verticadba - nproc 4096 
EOF



