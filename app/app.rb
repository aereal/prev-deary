module Deary
  class App < Padrino::Application
    register ScssInitializer
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Deary::XFromProtection

    set :settings_file, File.join(Padrino.root, 'config/settings.yml')
    register Deary::EnvironmentSettings

    enable :sessions
    enable :logging

    configure do
      Slim::Engine.set_default_options(
        format: :html5,
        tabsize: 2,
      )
    end

    configure :development do
      Slim::Engine.set_default_options(
        pretty: true,
      )
    end

    not_found do
      render "errors/404", layout: false
    end

    error 403 do
      render "errors/403", layout: false
    end

    error 500 do
      render "errors/500", layout: false
    end
  end
end
