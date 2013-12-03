require 'bundler/setup'
require 'padrino-core/cli/rake'

PadrinoTasks.use(:database)
PadrinoTasks.use(:sequel)
PadrinoTasks.init

error_documents = %w( 403 404 500 ).map {|error_code|
  "public/#{error_code}.html".tap {|error_doc|
    file error_doc do |t|
      require_relative 'config/boot'
      app = Deary::App.new
      File.open(t.name, 'w') do |f|
        f.puts app.helpers.send(:render, "errors/#{error_code}", layout: false)
      end
    end
  }
}

desc "Compile error documents"
task :error_documents => error_documents

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

desc "Run specs and take coverage"
task :coverage => [:coverage_prepare, :spec]

task :coverage_prepare do
  ENV['COVERAGE'] = '1'
end
