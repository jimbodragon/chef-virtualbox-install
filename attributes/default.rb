#
# Cookbook Name:: virtualbox
# Attributes:: default
#
# Copyright 2011, Joshua Timberman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# extend Vbox::Helpers

default['virtualbox']['version'] = '6.1.16'
default['virtualbox']['releasever'] = '140961'

default['virtualbox']['baseurl'] = "https://download.virtualbox.org/virtualbox/#{node['virtualbox']['version']}"
default['virtualbox']['url'] = "#{node['virtualbox']['baseurl']}/#{file_url_version}"

default['virtualbox']['ext_pack_name'] = "Oracle_VM_VirtualBox_Extension_Pack-#{node['virtualbox']['version']}-#{node['virtualbox']['releasever']}.vbox-extpack"
default['virtualbox']['ext_pack_url'] = "#{node['virtualbox']['baseurl']}/#{node['virtualbox']['ext_pack_name']}"

default['virtualbox']['default_interface'] = node['network']['default_interface']
