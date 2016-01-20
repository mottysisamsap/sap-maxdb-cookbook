name             'maxdb'
maintainer       'Stefan Weidemüller-Schmidt'
maintainer_email 'stefan.weidemueller-schmidt@sap.com'
license          "Apache 2.0"
description      'Installs/Configures maxdb'
#long_description <<-TEXT
version          '0.1.14'

depends 'ark', "0.4.0" 
depends 'lvm'
%w{ suse }.each do |os|
  supports os
end
