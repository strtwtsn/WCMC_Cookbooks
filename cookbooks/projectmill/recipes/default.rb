package "git-core"

bash "Download and install ProjectMill" do
user "root"
cwd "/home/ubuntu"
code <<-EOH
mkdir mapbox
cd /home/ubuntu/mapbox
git clone https://github.com/mapbox/projectmill.git
EOH
end

template "/home/ubuntu/mapbox/projectmill/package.json" do
source "package.json.erb"
mode 0600
end

bash "Install tilemill" do
user "root"
cwd "/home/ubuntu/mapbox/projectmill"
code <<-EOH
npm install
EOH
end

