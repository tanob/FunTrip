require 'cgi'
require 'bundler'
Bundler.require

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

enable :sessions
set :session_secret, 'Comedy is simply a funny way of being serious.'

error 400 do
  '<h1>Bad Request</h1>'
end

error 404 do
  '<h1>Not Found</h1>'
end

get '/' do
  erb :index
end

post '/register' do
  user_email = params[:email] || ''
  return 400 if user_email.empty?

  request_token = consumer.get_request_token
  session[user_email] = request_token
  redirect request_token.authorize_url(:oauth_callback => "http://#{env['HTTP_HOST']}/authorized/#{CGI::escape(user_email)}/")
end

get '/authorized/:user_email/' do
  user_email = params[:user_email] || ''
  return 400 if user_email.empty?
  request_token = session[user_email]
  return 404 unless request_token

  user = User.first_or_new(email: user_email)
  access_token = request_token.get_access_token
  user.access_token = access_token.token
  user.secret = access_token.secret
  user.save

  '<h1>Authorized!</h1><p>Now send your flight and hotel emails to <a href="mailto:twtrip@gmail.com">twtrip@gmail.com</a>'
end

def consumer
  @consumer ||= OAuth::Consumer.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'], site: 'https://api.tripit.com', authorize_url: 'https://www.tripit.com/oauth/authorize')
end

