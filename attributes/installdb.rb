# Path definitions 
default[:maxdb][:repoUrl] = 'http://server-example.com/location-of-binary/'
default[:maxdb][:version] = '7.8'
default[:maxdb][:zipFile] = 'maxdb-filename.tar.gz'

## /sapdb/data
default[:maxdb][:globalDataDir] = node[:maxdb][:sapdbDir] + '/data'

## sapdb/SID/db
default[:maxdb][:instDbDir] = node[:maxdb][:instDir] + '/db'

## /tmp/zipfileDir
#default[:maxdb][:unzipDir] = node[:maxdb][:tmpDir] + '/' + node[:maxdb][:zipFile].split('.')[0] 
default[:maxdb][:unzipDir] = node[:maxdb][:tmpDir] 

default[:maxdb][:fileUrl] = "#{node[:maxdb][:repoUrl]}/#{node[:maxdb][:version]}/#{node[:maxdb][:zipFile]}"

include_attribute "maxdb::createdb"
