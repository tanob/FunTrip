
module OAuth
  class Consumer
    CA_FILE = nil
  end
end

DataMapper::Logger.new($stdout, ENV['DM_LOG_LEVEL'] || :debug)
DataMapper.setup(:default, 'sqlite:tw-trip.db')

class User
  include DataMapper::Resource

  property :email, String, key: true
  property :access_token, String
  property :secret, String
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize
DataMapper.auto_upgrade!

