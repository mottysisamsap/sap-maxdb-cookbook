template node[:maxdb][:scriptPath] do
  source node[:maxdb][:scriptName]
  mode 0644
  owner node[:maxdb][:user]
  group node[:maxdb][:group]
  variables({
    :dbName => node[:maxdb][:dbName],
    :dbmOperatorName => node[:maxdb][:dbmOperator][:name],
    :dbmOperatorPassword => node[:maxdb][:dbmOperator][:password],
  })
  not_if { ::File.exists?(node[:maxdb][:scriptPath]) }
end

execute 'chmod' do
  user 'root'
  command "chmod 777 #{node[:maxdb][:volDataDir]}"
end

execute 'xuser' do
   cwd node[:maxdb][:dbmcliBinDir]
   user 'root'
   command "sudo -u root ./xuser -u #{node[:maxdb][:dbUser][:name]},#{node[:maxdb][:dbUser][:password]} -U #{node[:maxdb][:dbUser][:xuser]} -d #{node[:maxdb][:dbName]} -S INTERNAL set"
   not_if { ::File.exists?("/root/.XUSER.62") }
end 

# Workaround:
# As the service starts with the node[:maxdb][:user], this user must have the .XUSER file in his $HOME
# As we create node[:maxdb][:user] with no login rights, we cannot call xuser for him to add the .XUSER key
# Therefore we create the .XUSER for root and move the .XUSER file to $HOME of node[:maxdb][:user] (and adopt permissions)
execute 'move_xuser' do
   cwd node[:maxdb][:sapdbDir]
   command "cp /root/.XUSER.62 .XUSER.62 && chown #{node[:maxdb][:user]}:#{node[:maxdb][:group]} .XUSER.62" 
   not_if { ::File.exists?("#{node[:maxdb][:sapdbDir]}/.XUSER.62") }
end

# Don't execute if DB instance is already there
execute 'setup_db' do
   cwd node[:maxdb][:dbmcliBinDir]
   user 'root'
   command './dbmcli -i ' + node[:maxdb][:scriptPath]
   not_if { ::File.exists?("#{node[:maxdb][:sapdbDir]}/#{node[:maxdb][:SID]}/data/config/#{node[:maxdb][:dbName].upcase}.cfg") }
end
