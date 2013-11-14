PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Capybara::DSL
end

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
