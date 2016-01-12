service node[:maxdb][:serviceName] do
  only_if "test -x /etc/init.d/#{node[:maxdb][:serviceName]}"
  action :restart
  # I have no idea why I need to specify these commands again, as they should be default. However without it, it doesn't work...
  start_command "/etc/init.d/#{node[:maxdb][:serviceName]} start"
  stop_command "/etc/init.d/#{node[:maxdb][:serviceName]} stop"
  restart_command "/etc/init.d/#{node[:maxdb][:serviceName]} restart"
  # As the service status recognition on (at least) on SuSe doesn't work, speficy process pattern which it can use to check whether service is running
  pattern "#{node[:maxdb][:sapdbDir]}/#{node[:maxdb][:SID]}/db/pgm/kernel"
end
