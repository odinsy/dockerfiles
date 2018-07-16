node_name       ENV['CHEF_USER']
chef_server_url ENV['CHEF_SERVER_URL']
client_key      '/opt/knife/client.pem'

ssl_verify_mode :verify_none
