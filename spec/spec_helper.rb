PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app Deary::App
#   app Deary::App.tap { |a| }
#   app(Deary::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end

RSpec.configure do |config|
  FactoryGirl.find_definitions
  Capybara.app = Padrino.application
  Capybara.javascript_driver = :poltergeist

  app(Deary::App) do
    helpers do
      def matched_host?
        true # XXX
      end
    end
  end

  config.include Rack::Test::Methods
  config.include Capybara::DSL

  config.before(:each) do
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.start
    else
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
