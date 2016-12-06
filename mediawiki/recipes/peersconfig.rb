node[:deploy].each do |app_name, deploy|
  template "#{deploy[:deploy_to]}/current/peers.txt" do
    source "peers.txt.erb"
    mode 0660
    group deploy[:group]

    if platform?("ubuntu")
      owner "www-data"
    elsif platform?("amazon")
      owner "apache"
    end

    variables(
      :layers => node[:opsworks][:layers]
    )

   only_if do
     File.directory?("#{deploy[:deploy_to]}/current")
   end
  end
end
