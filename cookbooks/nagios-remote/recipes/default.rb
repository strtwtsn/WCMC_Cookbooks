bash "Install Nagios plugins on remote server" do
code <<-EOH
apt-get update
apt-get install -y libssl-dev
EOH
end

user "nagios" do
comment "Nagios User"
password "nagios"
end

remote_file "/usr/local/src/nagios-plugins-1.4.16.tar.gz" do
source "http://prdownloads.sourceforge.net/sourceforge/nagiosplug/nagios-plugins-1.4.16.tar.gz"
end

bash "Install Nagios plugins " do
user "root"
cwd "/usr/local/src"
code <<-EOH
tar xvzf nagios-plugins-1.4.16.tar.gz
cd nagios-plugins-1.4.16
./configure --with-nagios-user=nagios --with-nagios-group=nagios
make
make install
chown nagios.nagios /usr/local/nagios
chown -R nagios.nagios /usr/local/nagios/libexec
EOH
end

remote_file "/usr/local/src/nrpe-2.13.tar.gz" do
source "http://prdownloads.sourceforge.net/sourceforge/nagios/nrpe-2.13.tar.gz"
end

bash "Install NRPE" do
user "root"
cwd "/usr/local/src"
code <<-EOH
tar xvzf nrpe-2.13.tar.gz
cd nrpe-2.13
./configure
make all
make install-plugin
make install-daemon
make install-daemon-config
EOH
end

template "/usr/local/nagios/etc/nrpe.cfg" do
source "nrpe.cfg.erb"
end

template "/etc/init.d/nagios-nrpe-server" do
source "nrpe.erb"
end

bash "Add nagios-nrpe-server to runlevels" do
code <<-EOH
sudo chmod +x /etc/init.d/nagios-nrpe-server
sudo /usr/sbin/update-rc.d -f nagios-nrpe-server defaults
EOH
end

service "nagios-nrpe-server" do
    supports :restart => true, :status => true, :reload => true
    action [:enable,:start]
end
