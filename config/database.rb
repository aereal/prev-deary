require 'yaml'

config_from_yaml = YAML.load_file(File.join(Padrino.root, 'config/database.yml'))
config_for_current_env = config_from_yaml.fetch(Padrino.env)
database_config = config_for_current_env.merge(loggers: [logger])

Sequel::Model.plugin(:schema)
Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
Sequel::Model.db = Sequel.connect(database_config)
