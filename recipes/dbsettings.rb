template node[:maxdb][:settingsScriptPath] do
  source node[:maxdb][:settingsScriptName]
  mode 0644
  owner node[:maxdb][:user]
  group node[:maxdb][:group]
  variables({
    :dbName => node[:maxdb][:dbName],
    :dbmOperatorName => node[:maxdb][:dbmOperator][:name],
    :dbmOperatorPassword => node[:maxdb][:dbmOperator][:password],
    :dbUserName => node[:maxdb][:dbUser][:name],
    :dbUserPassword => node[:maxdb][:dbUser][:password],
    :volPath => node[:maxdb][:volDataDir],
    :dbParam_sessionTimeout => node[:maxdb][:db][:parameter][:sessionTimeout],
    :dbParam_cacheMemorySize => node[:maxdb][:db][:parameter][:cacheMemorySize],
    :dbParam_maxDataVolumes => node[:maxdb][:db][:parameter][:maxDataVolumes],
    :dbParam_maxUserTasks => node[:maxdb][:db][:parameter][:maxUserTasks],
    :dbParam_defaultCodePage => node[:maxdb][:db][:parameter][:defaultCodePage],
    :dbParam_autoUpdateStatistics => node[:maxdb][:db][:parameter][:autoUpdateStatistics],
    :dbParam_autoExtends => node[:maxdb][:db][:parameter][:autoExtend], 
    :dbParam_autoExtendsPercentage => node[:maxdb][:db][:parameter][:autoExtendPercentage], 
    :dbParam_logOverwrite => node[:maxdb][:db][:parameter][:logOverwrite],
    :dbParam_maxSQLLocks => node[:maxdb][:db][:parameter][:maxSQLLocks],
    :dbParam_maxServerTasks => node[:maxdb][:db][:parameter][:maxServerTasks],
    :dbParam_joinTableBufferSize => node[:maxdb][:db][:parameter][:joinTableBufferSize],
    :dbParam_joinSearchLevel => node[:maxdb][:db][:parameter][:joinSearchLevel],
    :dbParam_maxTransactions => node[:maxdb][:db][:parameter][:maxTransactions],
    :dbParam_maxCPUs => node[:maxdb][:db][:parameter][:maxCPUs],
    :dbParam_maxLogVolumes => node[:maxdb][:db][:parameter][:maxLogVolumes],
    :dbParam_autoLogBackup => node[:maxdb][:db][:parameter][:autoLogBackup],
    :dbParam_autoRecreateBadIndex => node[:maxdb][:db][:parameter][:autoRecreateBadIndex],
    :dbParam_useSharedSQL => node[:maxdb][:db][:parameter][:useSharedSQL],
    :dbParam_useAlternateAllocatorForServer => node[:maxdb][:db][:parameter][:useAlternateAllocatorForServer]
  })
end

# Don't execute if DB instance is already there
execute 'db_settings' do
   cwd node[:maxdb][:dbmcliBinDir]
   user 'root'
   command './dbmcli -u ' + node[:maxdb][:dbmOperator][:name] + ',' + node[:maxdb][:dbmOperator][:password] + ' -d ' + node[:maxdb][:dbName] + ' -i ' + node[:maxdb][:settingsScriptPath]
end
