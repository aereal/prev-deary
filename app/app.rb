module Deary
  class App < Padrino::Application
    register ScssInitializer
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Deary::XFromProtection

    enable :sessions

    set :site_title, 'Deary'
    set :title_placeholder, '✖'
    set :body_placeholder, '川は洗濯、山は芝刈りです。'

    configure do
      Slim::Engine.set_default_options(
        format: :html5,
        tabsize: 2,
      )

      set :host, ENV['APP_HOST']
    end

    configure :development do
      Slim::Engine.set_default_options(
        pretty: true,
      )
    end
  end
end
