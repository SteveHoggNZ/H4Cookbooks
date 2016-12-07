node[:deploy].each do |app_name, deploy|
  execute "mysql-setup" do
    command "/usr/bin/mysql -h#{deploy[:database][:host]} -u#{deploy[:database][:username]} -p#{deploy[:database][:password]} #{deploy[:database][:database]} -e 'CREATE TABLE #{node[:app][:table]} (id int primary key, message text)'"
    not_if "/usr/bin/mysql -h#{deploy[:database][:host]} -u#{deploy[:database][:username]} -p#{deploy[:database][:password]} #{deploy[:database][:database]} -e'SHOW TABLES' | grep #{node[:app][:table]}"
    action :run
  end
end
