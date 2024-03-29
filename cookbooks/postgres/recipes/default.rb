# Download Postgres binary

package "libreadline-dev"

remote_file "/usr/local/src/postgresql-9.2.1.tar.gz" do
source "http://ftp.postgresql.org/pub/source/v9.2.1/postgresql-9.2.1.tar.gz"
end

bash "Extract and install Postgres 9.2" do
user "root"
cwd "/usr/local/src"
code <<-EOH
tar xvzf postgresql-9.2.1.tar.gz
cd postgresql-9.2.1
./configure
make
make install
EOH
end

user "postgres" do
password "postgres"
supports :manage_home => true
home "/home/postgres"
end


bash "Set postgres paths" do
user "root"
code <<-EOH
sudo echo "export LD_LIBRARY_PATH=/usr/local/pgsql/lib" | sudo tee -a ~postgres/.profile
sudo echo "export PATH=$PATH:/usr/local/pgsql/bin" | sudo tee -a ~postgres/.profile
source /etc/profile
EOH
end



# Install startup script

bash "Install startup script for Postgresql" do
user "root"
code <<-EOH
cp /usr/local/src/postgresql-9.2.1/contrib/start-scripts/linux /etc/init.d/postgresql
chmod +x /etc/init.d/postgresql
/usr/sbin/update-rc.d -f postgresql defaults
EOH
end

bash "Create data directory" do
code <<-EOH
mkdir /usr/local/pgsql/data
chown postgres:postgres /usr/local/pgsql/data
EOH
end

bash "Initialize data directory" do
user "postgres"
code <<-EOH
/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data/
EOH
end


# Start postgres service

service "postgresql" do
supports :restart => true, :status => true, :reload => true
action [:enable,:start]
end
