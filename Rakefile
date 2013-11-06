require 'bundler/setup'
require 'padrino-core/cli/rake'

PadrinoTasks.use(:database)
PadrinoTasks.use(:sequel)
PadrinoTasks.init

namespace :db do
  %w(create drop migrate).each do |sub_task|
    t = Rake.application["sq:#{sub_task}"]

    desc t.comment
    task sub_task => t.name
  end
end
