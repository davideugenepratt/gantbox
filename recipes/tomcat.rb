#
# Cookbook:: gantbox
# Recipe:: tomcat
#
# Copyright:: 2018, The Authors, All Rights Reserved.

tomcatversion = node.read('gantbox', 'tomcat', 'version') ? node['gantbox']['tomcat']['version'] : '8.5.30'

tomcat_install 'gant' do
  verify_checksum false
  version tomcatversion
end

tomcat_service 'gant' do
  action [:enable,:start]
  # env_vars [{ 'CATALINA_PID' => '/my/special/path/tomcat.pid' }]
end