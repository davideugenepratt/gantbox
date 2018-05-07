#
# Cookbook:: gantbox
# Recipe:: tomcat
#
# Copyright:: 2018, The Authors, All Rights Reserved.

tomcatversion = node.read('gantbox', 'tomcat', 'version') ? node['gantbox']['tomcat']['version'] : '8.5.30'
tomcatusers = node.read('gantbox', 'tomcat', 'users') ? node['gantbox']['tomcat']['users'] : [ { "username" => "admin" , "password" => "password" } ]

tomcat_install 'gant' do
  verify_checksum false
  version tomcatversion
end

template '/opt/tomcat_gant/webapps/manager/META-INF/context.xml' do
  source 'context.xml.erb'
  owner 'tomcat_gant'
  group 'tomcat_gant'
  mode '640'
end

template '/opt/tomcat_gant/conf/tomcat-users.xml' do
  source 'tomcat-users.xml.erb'
  owner 'tomcat_gant'
  group 'tomcat_gant'
  mode '600'
  variables(:users => tomcatusers)
end

tomcat_service 'gant' do
  action [:enable,:start]
  # env_vars [{ 'CATALINA_PID' => '/my/special/path/tomcat.pid' }]
end