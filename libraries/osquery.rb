require 'inspec/utils/object_traversal'
require 'json'

class OSQuery < Inspec.resource(1)
  name 'osquery'

  desc '
    run osquery via InSpec.
  '

  example "
    describe osquery('SELECT * FROM users;') do
      its('length') { should_not eq 0 }
    end
  "
  attr_reader :params

  include ObjectTraverser

  def initialize(query)
    @params = { 'result_set' => [], 'length' => 0 }
    @cli = "osqueryi"
    exec(query)
  end

  def exec(query)
    command = "#{@cli} --json \"#{query}\""
    @res = inspec.command(command)
    @params['result_set'] = JSON.parse @res.stdout unless @res.stdout.eql?('')
    @params['length'] = @params['result_set'].size
    @params['result_set'].first.each { |k,v| @params[k.to_s] = v }
  end

  def stdout
    @res.stdout
  end

  def stderr
    @res.stderr
  end

  def exit_status
    @res.exit_status.to_i
  end

  # This is borrowed directly from https://github.com/inspec/inspec/blob/master/lib/inspec/resources/json.rb
  def method_missing(*keys)
    keys.shift if keys.is_a?(Array) && keys[0] == :[]
    value(keys)
  end

  def value(key)
    extract_value(key, params)
  end
end
