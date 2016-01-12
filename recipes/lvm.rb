
# required for lvm to work ...
if File.exists? "/opt/chef/embedded/bin/gem"
  gem_package "di-ruby-lvm" do
    gem_binary "/opt/chef/embedded/bin/gem"
    version "~> 0.1.3"
    action :nothing
  end.run_action(:install)
end
Gem.clear_paths

# need the opscode lvm_* providers ...
include_recipe "lvm"

# ----- MaxDB global directory (e.g. /sapdb)
directory "#{node[:maxdb][:sapdbDir]}" do
  owner node[:maxdb][:user]
  group node[:maxdb][:group]
  mode 0755
  action :create
  recursive true
  not_if { ::File.exists?(node[:maxdb][:sapdbDir]) }
end

lvm_volume_group 'sapdb_vg_global' do
	physical_volumes ['/dev/sapdb_pv_global']
	logical_volume 'sapdb_lv_global' do
    size        '99%VG'
    filesystem  'ext3'
    mount_point location: "#{node[:maxdb][:sapdbDir]}", options: 'defaults,noatime,nodiratime'
    end
    not_if { ::File.exists?(node[:maxdb][:sapdbDir]) }
end

# ----- MaxDB instance directory (e.g. /sapdb/<SID>)
directory "#{node[:maxdb][:instDir]}" do
  owner node[:maxdb][:user]
  group node[:maxdb][:group]
  mode 0755
  action :create
  recursive true
  not_if { ::File.exists?(node[:maxdb][:instDir]) }
end

lvm_volume_group 'sapdb_vg_instance' do
	physical_volumes ['/dev/sapdb_pv_instance']
	logical_volume 'sapdb_lv_instance' do
    size        '99%VG'
    filesystem  'ext3'
    mount_point location: "#{node[:maxdb][:instDir]}", options: 'defaults,noatime,nodiratime'
    end
    not_if { ::File.exists?(node[:maxdb][:instDir]) }
end

# ----- MaxDB DATA directory
directory "#{node[:maxdb][:volDataDir]}" do
  owner node[:maxdb][:user]
  group node[:maxdb][:group]
  mode 0755
  action :create
  recursive true
  not_if { ::File.exists?(node[:maxdb][:volDataDir]) }
end

lvm_volume_group 'sapdb_vg_data' do
	physical_volumes ['/dev/sapdb_pv_data']
	logical_volume 'sapdb_lv_data' do
    size        '99%VG'
    filesystem  'ext3'
    mount_point location: "#{node[:maxdb][:volDataDir]}", options: 'defaults,noatime,nodiratime'
    end
    not_if { ::File.exists?(node[:maxdb][:volDataDir]) }
end

# ----- MaxDB LOG directory
directory "#{node[:maxdb][:volLogDir]}" do
  owner node[:maxdb][:user]
  group node[:maxdb][:group]
  mode 0755
  action :create
  recursive true
  not_if { ::File.exists?(node[:maxdb][:volLogDir]) }
end

lvm_volume_group 'sapdb_vg_log' do
	physical_volumes ['/dev/sapdb_pv_log']
	logical_volume 'sapdb_lv_log' do
    size        '99%VG'
    filesystem  'ext3'
    mount_point location: "#{node[:maxdb][:volLogDir]}", options: 'defaults,noatime,nodiratime'
    end
    not_if { ::File.exists?(node[:maxdb][:volLogDir]) }
end
