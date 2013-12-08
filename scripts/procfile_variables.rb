#!/usr/bin/env ruby

require 'bundler/setup' unless defined?(Bundler)
require 'thor'

class Array
  def to_hash
    self.reduce({}) {|res, (k, v)| res.merge(k => v) }
  end
end

Class.new(Thor) do
  VARIABLE_DECLARATION_PATTERN = /\${?(?<name>\w+)(?::-(?<default>[^}]*))?}?/.freeze

  desc "list", "Show variables used in Procfile"
  method_option :procfile, aliases: %w( -f ), default: 'Procfile', type: :string, desc: 'Path to Procfile'
  method_option :dotenv, aliases: %w( -e ), default: '.env', type: :string, desc: 'Path to .env'
  def list
    usages = find_variable_usage(File.read(options[:procfile]))
    definitions = find_variable_definitions(File.read(options[:dotenv]))
    usages.each do |usage|
      definition = definitions.find {|d| d['name'] == usage['name'] }
      usage.update(definition) if definition
    end
    puts format_variables(usages)
  end

  no_tasks do
    def format_variables(variables)
      keys = %w( name value default )
      longest_length = keys.map {|k|
        [k, variables.map {|var| (var[k] || '').length }.max]
      }.to_hash
      variables.flat_map {|v|
        keys.map {|n|
          "#{n}:#{(v[n] || '-').ljust(longest_length[n] || 0)}"
        }.join(" ")
      }.join($/)
    end

    def find_variable_usage(procfile_body)
      matches = procfile_body.each_line.map {|line| VARIABLE_DECLARATION_PATTERN.match(line) }.compact
      matches.map {|m| m.names.reduce({}) {|res, name| res.merge(name => m[name]) } }
    end

    def find_variable_definitions(dot_env_body)
      dot_env_body.each_line.map {|l| %w( name value ).zip(l.strip.split('=', 2)).to_hash }
    end
  end
end.start
