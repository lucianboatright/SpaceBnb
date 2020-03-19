require 'sinatra/base'
require './lib/space'
require './lib/user'
require './lib/booking'
require './lib/database_connection'

class Makersbnb < Sinatra::Base
  enable :sessions

  get '/' do
    erb :index
  end

  get '/spaces' do
    @spaces = Space.all
    erb :spaces
  end

  get '/spaces/new' do
    erb :form
  end

  post '/spaces/new' do
    @space = Space.add(name: params[:name], price: params[:price], description: params[:description], image: params[:image])
    redirect '/spaces'
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    @user = User.add(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
    erb :registration_success
  end

  get '/session' do
    erb :session
  end

  post '/session/new' do
    @user = User.authenticate(email: params[:email], password: params[:password])
    session[:user_id]= @user.id
    erb :new
  end

  get '/booking/new' do
    space_id = params[:space_id]
    @space = Space.get(space_id: space_id)
    erb :booking_form
  end

  post '/booking/new' do
    space_id = params[:space_id]
    start_date = params[:start_date]
    finish_date = params[:finish_date]
    user_id = session[:user_id]
    Booking.add(start_date: start_date, finish_date: end_date, space_id: space_id, user_id: user_id)
    redirect '/bookings'
  end

  get '/bookings' do
    user_id = session[:user_id]
    @bookings = Booking.all(user_id)
    erb :bookings
  end

  get '/test_drive' do
    erb :test_drive
  end

  run! if app_file == $0

end