set :stage, :production

server 'aereal.org', user: 'www-app', roles: %i( proxy app ), ssh_options: {
  keys: ['~/.ssh/id_rsa'].map {|f| File.expand_path(f) },
  forward_agent: false,
  auth_methods: %w( publickey ),
}
