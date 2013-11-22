source 'https://rubygems.org'

# Project requirements
gem 'padrino', '0.11.4'
gem 'rake'

# Component requirements
gem 'sass'
gem 'slim'
gem 'pg'
gem 'sequel'
gem 'kramdown'
gem 'oj'

# Test requirements
group :test do
  gem 'rspec'
  gem 'rack-test', require: 'rack/test'
  gem 'capybara', require: %w(capybara capybara/rspec)
  gem 'poltergeist', require: 'capybara/poltergeist'
  gem 'database_cleaner'
  gem 'fuubar'
  gem 'factory_girl'
end

# Development requirements
group :development do
  gem 'pry-padrino'
  gem 'pry-doc'
  gem 'pry-remote'
  gem 'foreman'

  gem 'capistrano', '>= 3.0.0', require: false
  gem 'capistrano-rbenv', github: 'capistrano/rbenv', require: false
  gem 'capistrano-bundler', github: 'capistrano/bundler', require: false
end

# Production requirements
group :production do
  gem 'puma'
  gem 'newrelic_rpm'
end
