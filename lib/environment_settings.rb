require 'yaml'

module Deary
  module EnvironmentSettings
    def self.registered(app)
      unless app.respond_to?(:settings_file)
        raise "app.settings_file must be configured before #{self} registered"
      end

      settings_with_env = YAML.load_file(app.settings_file)
      settings_with_env.each do |(env, settings)|
        app.configure(env) do
          settings.each do |(k, v)|
            app.set(k, v)
          end
        end
      end
    end
  end
end
