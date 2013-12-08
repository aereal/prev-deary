PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)

if ENV['COVERAGE'] == '1'
  require 'bundler/setup' unless defined?(Bundler)
  require 'simplecov'
  require 'coveralls'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter,
  ]
  SimpleCov.start do
    add_filter 'spec/'
  end
end

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
