#
# Cookbook:: gantbox
# Recipe:: java
#
# Copyright:: 2018, The Authors, All Rights Reserved.

javaversion = node.read('gantbox', 'java', 'version') ? node['gantbox']['java']['version'] : '8'

if node['platform'] == 'redhat' || node['platform'] == 'centos'
  package "java-1.#{javaversion}.0-openjdk-devel" do
    action :install
  end
else
  bash 'add java repos' do
    code <<-EOH
      apt-get update
    EOH
  end

  # The openJDK 9 package is packaged wrong so this is a temporary workaround.
  if javaversion.to_s == '9'
    bash 'fix java9 problem' do
      code <<-EOH
        apt-get install -y openjdk-9-jdk
        dpkg --configure -a
        dpkg -i --force-overwrite '/var/cache/apt/archives/openjdk-9-jdk_9~b114-0ubuntu1_amd64.deb'
      EOH
    end
  else
    package "openjdk-#{javaversion}-jdk" do
      action :install
    end
  end

end
