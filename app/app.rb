module Deary
  class App < Padrino::Application
    register ScssInitializer
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    set :site_title, 'Deary'
    set :title_placeholder, '✖'

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
