#
# Cookbook Name:: maxdb
# Recipe:: installdb
#
# Copyright 2013, SAP AG
#
# All rights reserved - Do Not Redistribute
#

group node[:maxdb][:group] do
  not_if "getent group | grep #{node[:maxdb][:group]}"
end

user node[:maxdb][:user] do
  comment "maxdb service user"
  shell "/bin/false"
  gid node[:maxdb][:group]
  home node[:maxdb][:sapdbDir]
  action :create
  not_if "getent passwd | grep #{node[:maxdb][:user]}"
end

ark node[:maxdb][:tmpDir] do
   path '/'
   url node[:maxdb][:fileUrl]
   mode 0755
   action :put
   strip_leading_dir false
  not_if { ::File.exists?(node[:maxdb][:globalDataDir]) }
end

execute 'run_sdbinst' do
  cwd node[:maxdb][:unzipDir]
  user 'root'
  command "./SDBINST -global_prog #{node[:maxdb][:programDir]} -global_data #{node[:maxdb][:globalDataDir]} -path #{node[:maxdb][:instDbDir]} -private_datapath #{node[:maxdb][:instDataDir]} -profile Server -o #{node[:maxdb][:user]} -g #{node[:maxdb][:group]} -i #{node[:maxdb][:SID]} -b"
  not_if { ::File.exists?(node[:maxdb][:globalDataDir]) }
end

template  "/etc/init.d/#{node[:maxdb][:serviceName]}" do
   source node[:maxdb][:serviceName]
   mode 0755
   variables(
   :dbName => node[:maxdb][:dbName],
   :dbUser => node[:maxdb][:user],
   :xuser => node[:maxdb][:dbUser][:xuser],
   :dbProgramDir => node[:maxdb][:programDir],
   :dbProgramDirBin => node[:maxdb][:dbmcliBinDir])
   not_if { ::File.exists?("/etc/init.d/#{node[:maxdb][:serviceName]}") }
end

service node[:maxdb][:serviceName] do
  supports :restart => true, :start => true, :stop => true, :status => false
  action [ :enable ]
end
