$stdout.sync = true # https://github.com/ddollar/foreman/wiki/Missing-Output

require 'bundler'
Bundler.require :default, :mailman

require './common'

Mailman.config.logger.level = Logger::DEBUG
Mailman.config.ignore_stdin = true
Mailman.config.rails_root = nil
Mailman.config.pop3 = {
  username: ENV['PLANS_EMAIL'],
  password: ENV['POP_PASSWORD'],
  server:   ENV['POP_SERVER'],
  port:     ENV['POP_PORT'].to_i,
  ssl:      ENV['POP_SSL'] == 'true',
}

Mailman::Application.run do
  default do
    puts message.inspect
  end
end

