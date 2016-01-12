default[:maxdb][:scriptName] = 'createdb'
default[:maxdb][:settingsScriptName] = 'dbsettings'
default[:maxdb][:dbName] = 'DEFAULT'

# paths
## path to scripts
default[:maxdb][:scriptPath] = node[:maxdb][:tmpDir] + '/' + node[:maxdb][:scriptName] 
default[:maxdb][:settingsScriptPath] = node[:maxdb][:tmpDir] + '/' + node[:maxdb][:settingsScriptName] 

# users
## dbm operator
default[:maxdb][:dbmOperator][:name] = 'DBM'
default[:maxdb][:dbmOperator][:password] = 'DBM'
## db sys admin
default[:maxdb][:dbUser][:name] = 'DBADMIN'
default[:maxdb][:dbUser][:password] = 'admin'
default[:maxdb][:dbUser][:xuser] = 'dba'

## DB parameters
default[:maxdb][:db][:parameter][:sessionTimeout] = '0'         # 0 = unlimited
default[:maxdb][:db][:parameter][:cacheMemorySize] = '10000'
default[:maxdb][:db][:parameter][:maxDataVolumes] = '64'
default[:maxdb][:db][:parameter][:maxUserTasks] = '2500'
default[:maxdb][:db][:parameter][:defaultCodePage] = 'UNICODE'  # UNICODE or ASCII
default[:maxdb][:db][:parameter][:autoUpdateStatistics] = 'ON'
default[:maxdb][:db][:parameter][:autoExtend] = 'ON'            # Auto extend volumes
default[:maxdb][:db][:parameter][:autoExtendPercentage] = '90'  # Auto extend on percentage
default[:maxdb][:db][:parameter][:logOverwrite] = 'ON'  
default[:maxdb][:db][:parameter][:maxSQLLocks] = '900000'  
default[:maxdb][:db][:parameter][:maxServerTasks] = '4096'  
default[:maxdb][:db][:parameter][:joinTableBufferSize] = '16384'  
default[:maxdb][:db][:parameter][:joinSearchLevel] = '4'  
default[:maxdb][:db][:parameter][:maxTransactions] = '32767'  
default[:maxdb][:db][:parameter][:maxCPUs] = '3'  
default[:maxdb][:db][:parameter][:maxLogVolumes] = '4'  
# ALL All indices that are detected to be bad are automatically repaired.
# UNIQUE Unique indices are automatically repaired if they are broken.
# OFF The database system does not perform any action if bad indices are detected.
default[:maxdb][:db][:parameter][:autoRecreateBadIndex] = 'ALL'   
default[:maxdb][:db][:parameter][:autoLogBackup] = 'off'       # on or off (must be lower case)
# Don't activate shared SQL Cache until this bug is fixed: http://maxdb.sap.com/webpts -> 1242614
default[:maxdb][:db][:parameter][:useSharedSQL] = 'NO'       # YES or NO (must be upper case)
default[:maxdb][:db][:parameter][:useAlternateAllocatorForServer] = 'YES'       # YES or NO (must be upper case)
