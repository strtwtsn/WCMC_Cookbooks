bash "Install sqlite3 for node" do
user "root"
code <<-EOH
npm install sqlite3 -g
EOH
end

