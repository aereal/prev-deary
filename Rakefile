require 'bundler/setup'
require 'padrino-core/cli/rake'

PadrinoTasks.use(:database)
PadrinoTasks.use(:sequel)
PadrinoTasks.init

namespace :ci do
  namespace :prepare do
    task :npm do
      sh 'npm', 'install'
    end

    task :bower => :npm do
      sh './node_modules/.bin/bower', 'install'
    end

    task :grunt => :bower do
      sh './node_modules/.bin/grunt'
    end
    task :assets => :grunt

    task :database_config do
      require 'yaml'
      # See also: http://about.travis-ci.org/docs/user/database-setup/
      config = {
        test: {
          adapter: 'postgres',
          database: 'deary_test',
          user: 'postgres',
          password: '',
          host: 'localhost',
        }
      }
      File.open('config/database.yml', 'w') do |f|
        f.write(YAML.dump(config))
      end
    end
  end

  task :prepare => %w(prepare:database_config db:create db:migrate prepare:assets)
end

namespace :db do
  %w(create drop migrate).each do |sub_task|
    t = Rake.application["sq:#{sub_task}"]

    desc t.comment
    task sub_task => t.name
  end
end
