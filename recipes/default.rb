package 'nginx'

# Create a directroy to put our files
directory '/chef101/www'  do
  owner 'www-data'
  group 'www-data'
  mode  0770
  recursive true
end

# Put a file with some very minimal content
file '/chef101/www/index.html' do
  content 'chef101'
  owner 'www-data'
  group 'www-data'
  mode  0770
end

# add an nginx configuration to look in that directory
template '/etc/nginx/nginx.conf' do
  owner 'root'
  group 'root'
  mode  0754
  notifies :restart, 'service[nginx]'
  variables({
    :chef101_loc => '/var/www'
  })
end

# define and enable and start the nginx service
service 'nginx' do
  action [:enable, :start]
end
