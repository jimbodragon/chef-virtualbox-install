#
# Cookbook Name:: virtualbox
# Recipe:: systemservice
#
# Copyright 2012, Ringo De Smet
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

extend Vbox::Helpers
include_recipe "#{cookbook_name}::user"

template '/etc/init.d/vboxcontrol' do
  source 'vboxcontrol.erb'
  mode '0755'
  variables(user: node[cookbook_name]['user'])
end

directory '/etc/virtualbox' do
  mode '0755'
end

cookbook_file '/etc/virtualbox/machines_enabled' do
  source 'machines_enabled'
  mode '0644'
  not_if FileTest.exists?('/etc/virtualbox/machines_enabled')
end

host_interface = node[cookbook_name]['default_interface']
addresses = node['network']['interfaces'][host_interface]['addresses']
host_ip = 'unknown'
addresses.each do |ip, params|
  host_ip = ip if params['family'].eql?('inet')
end

template '/etc/virtualbox/config' do
  source 'config.erb'
  mode '0644'
  variables(
      host_interface: host_interface,
      host_ip: host_ip
  )
end

service 'vboxcontrol' do
  action [:enable, :start]
end

execute 'enable virtualbox autostart' do
  command "VBoxManage setproperty autostartdbpath /virtualmachines/vbox/autostartdbpath"
end

directory '/virtualmachines' do
  mode '0777'
end

directory '/virtualmachines/vbox' do
  mode '0777'
end

directory '/virtualmachines/vbox/autostartdbpath' do
  mode '0777'
end