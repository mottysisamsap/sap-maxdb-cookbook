# InitV service name and init dir
default[:maxdb][:serviceName] = 'maxdb'

default[:maxdb][:tmpDir] = '/tmp'
default[:maxdb][:sapdbDir] = '/sapdb'

## /sapdb/programs
default[:maxdb][:programDir] = node[:maxdb][:sapdbDir] + '/programs'

## path to binaries   /sapdb/programs/bin
default[:maxdb][:dbmcliBinDir] = node[:maxdb][:programDir] + '/bin'

default[:maxdb][:SID] = 'MD1'

##sapdb/<sid>
default[:maxdb][:instDir] = node[:maxdb][:sapdbDir] + '/' + node[:maxdb][:SID]

##sapdb/<sid>/db/bin
default[:maxdb][:instanceBinDir] = node[:maxdb][:instDir] + '/db/bin'

## sapdb/<sid>/data
default[:maxdb][:instDataDir] = node[:maxdb][:instDir] + '/data'

## /sapdb/<sid>/sapdata1
default[:maxdb][:volDataDir] = node[:maxdb][:instDir] + '/sapdata1'

## /sapdb/<sid>/saplog1
default[:maxdb][:volLogDir] = node[:maxdb][:instDir] + '/saplog1'

## User/group attributes
default[:maxdb][:user] = 'sdb'
default[:maxdb][:group] = 'sdba'

default[:maxdb][:uselvm] = true

