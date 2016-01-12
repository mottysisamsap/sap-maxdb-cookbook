#if "#{node['maxdb']['uselvm']}" == "true"
#	include_recipe 'maxdb::lvm'
#		end 
include_recipe 'maxdb::installdb'
include_recipe 'maxdb::lvm'
include_recipe 'maxdb::createdb'
include_recipe 'maxdb::dbsettings'
include_recipe 'maxdb::startdb'
