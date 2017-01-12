apt_package ['nginx', 'nodejs', 'npm' ]

service 'nginx' do
  action :enable
end
