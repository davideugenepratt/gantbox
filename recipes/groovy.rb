#
# Cookbook:: gantbox
# Recipe:: groovy
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe '::java'

package 'unzip' do
  action :install
end

package 'zip' do
  action :install
end

bash 'install groovy' do
  users = []

  if node.read 'gantbox', 'node', 'users'
    users = node['gantbox']['node']['users']
  else
    node['etc']['passwd'].each do |systemuser, _data|
      users.push(systemuser) if Dir.exist? '/home/' + systemuser
    end
  end
  
  groovyversion = node.read('gantbox', 'groovy', 'version') ? node['gantbox']['groovy']['version'] : ''

  users.each do |username, _data|
    next unless Dir.exist? '/home/' + username

    user username

    cwd '/home/' + username

    environment('HOME' => ::Dir.home(username), 'USER' => username)

    code <<-EOH
      curl -s get.sdkman.io | bash
      source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk install groovy #{groovyversion}
    EOH
  end
end

