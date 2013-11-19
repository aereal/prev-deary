set :application, 'deary'
set :repo_url, 'git://github.com/aereal/deary.git'
set :branch, 'master'

set :deploy_to, "/srv/www-app/aereal.org/#{fetch(:application)}"
set :scm, :git
set :pty, true

set :linked_dirs, %w(
  tmp/sockets
  vendor/bundle
)

set :rbenv_type, :user
set :rbenv_ruby, '2.0.0-p247'

set :supervisor_program_name, 'deary'

namespace :proxy do
  desc 'Reload nginx config'
  task :reload do
    on roles(:proxy) do
      sudo "nginx", "-s", "reload"
    end
  end
end

namespace :log do
  desc 'Show application log'
  task :app do
    interruptable do
      on roles(:app) do
        sudo "supervisorctl", "tail", "-f", fetch(:supervisor_program_name)
      end
    end
  end

  desc 'Access log'
  task :access do
    interruptable do
      on roles(:proxy) do
        execute :tail, "-F", "/var/log/nginx/diary.aereal.org.access.log"
      end
    end
  end
end

namespace :app do
  desc 'Restart application'
  task :restart do
    on roles(:app) do
      sudo "kill", "-SIGUSR2", "$(sudo supervisorctl pid #{fetch(:supervisor_program_name)})"
    end
  end

  desc 'Start application'
  task :start do
    on roles(:app) do
      sudo "supervisorctl", "start", fetch(:supervisor_program_name)
    end
  end

  desc 'Stop application'
  task :stop do
    on roles(:app) do
      sudo "supervisorctl", "stop", fetch(:supervisor_program_name)
    end
  end

  desc 'Check the status of application'
  task :status do
    on roles(:app) do
      sudo "supervisorctl", "status", fetch(:supervisor_program_name)
    end
  end
end

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app) do
      Rake::Task['app:restart'].invoke
    end
  end

  after :finishing, 'deploy:cleanup'
end

def interruptable(&block)
  block.call
rescue Interrupt
  warn "\nCaught SIGTERM"
  exit 0
end
