#
# Cookbook:: gantbox
# Recipe:: grails
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe '::groovy'

bash 'install grails' do
  users = []

  if node.read 'gantbox', 'node', 'users'
    users = node['gantbox']['node']['users']
  else
    node['etc']['passwd'].each do |systemuser, _data|
      users.push(systemuser) if Dir.exist? '/home/' + systemuser
    end
  end
  
  grailsversion = node.read('gantbox', 'grails', 'version') ? node['gantbox']['grails']['version'] : ''

  users.each do |username, _data|
    next unless Dir.exist? '/home/' + username

    user username

    cwd '/home/' + username

    environment('HOME' => ::Dir.home(username), 'USER' => username)

    code <<-EOH
      source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk install grails #{grailsversion}
    EOH
  end
end