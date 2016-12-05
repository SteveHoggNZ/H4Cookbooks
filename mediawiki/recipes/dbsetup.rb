node[:deploy].each do |app_name, deploy|
  execute "mysql-create-table" do
    command "/usr/bin/mysql -h#{deploy[:database][:host]} -u#{deploy[:database][:username]} -p#{deploy[:database][:password]} #{deploy[:database][:database]} -e'CREATE TABLE #{node[:mediawiki][:dbtable]}(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    author VARCHAR(63) NOT NULL,
    message TEXT,
    PRIMARY KEY (id)
  )'"
    not_if "/usr/bin/mysql -h#{deploy[:database][:host]} -u#{deploy[:database][:username]} -p#{deploy[:database][:password]} #{deploy[:database][:database]} -e'SHOW TABLES' | grep #{node[:mediawiki][:dbtable]}"
    action :run
  end
end
