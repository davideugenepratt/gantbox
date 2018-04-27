name 'gantbox'
maintainer 'David Eugene Pratt'
maintainer_email 'david@davideugenepratt.com'
license 'All Rights Reserved'
description 'Installs/Configures gantbox'
long_description 'Installs/Configures gantbox'
version '0.0.1'
chef_version '>= 12.14' if respond_to?(:chef_version)
supports 'ubuntu'
supports 'centos'
issues_url 'https://github.com/davideugenepratt/gantbox/issues'
source_url 'https://github.com/davideugenepratt/gantbox'

depends 'tomcat'
