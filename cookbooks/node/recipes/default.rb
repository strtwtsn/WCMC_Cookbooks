remote_file "/usr/local/src/node-v0.8.6.tar.gz" do
source "http://nodejs.org/dist/v0.8.6/node-v0.8.6.tar.gz"
end

bash "Extract and install node" do
user "root"
cwd "/usr/local/src"
code <<-EOH
tar xvf node-v0.8.6.tar.gz
cd node-v0.8.6
./configure
make
make install
EOH
end

