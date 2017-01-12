template "/etc/nginx/sites-available/default" do
  source "nginx-default-site"
  mode 0644
  group "root"
  owner "root"

  variables(
    :website_server_name => node[:website_server_name]
  )

 only_if do
   File.directory?("/etc/nginx/sites-available")
 end
end

execute "nginx-restart" do
  command "service nginx reload"
  action :run
end
