require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    binding.pry
    @username = params[:username]
    @password = params[:password]
    @email = params[:email]
    unless @username.empty? || @password.empty? || @email.empty?
      User.create(params)
    end
    #make new user here
    redirect '/tweets'
  end

  get '/tweets' do
    erb :'/tweets/tweets'
  end
end
