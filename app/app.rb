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
  end
end
