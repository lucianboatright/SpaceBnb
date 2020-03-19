require_relative 'space'
require 'date'
require 'pg'
require_relative 'database_connection'


class Booking

  attr_reader :id, :start_date, :finish_date, :user_id, :space_id
  
  def self.all(user_id:)
    if ENV['ENVIRONMENT'] == 'test'
      DatabaseConnection.setup('makersbnb_test')
    else
      DatabaseConnection.setup('makersbnb')
    end

    result = DatabaseConnection.query("SELECT * FROM bookings WHERE user_id = '#{user_id}';")
    result.map do |booking|
      Booking.new(id: booking['id'], start_date: booking['start_date'], finish_date: booking['finish_date'], user_id: booking['user_id'], space_id: booking['space_id'])  
    end
    #Get bookings from database and wrap in new booking objects
  end

  def self.add(start_date:, finish_date:, user_id:, space_id:)
    if ENV['ENVIRONMENT'] == 'test'
      DatabaseConnection.setup('makersbnb_test')
    else
      DatabaseConnection.setup('makersbnb')
    end
    
    booking = DatabaseConnection.query("INSERT INTO bookings (start_date, finish_date, user_id, space_id) VALUES('#{start_date}', '#{finish_date}', '#{user_id}', '#{space_id}') RETURNING id, start_date, finish_date, user_id, space_id;")
    Booking.new(id: booking[0]['id'], start_date: booking[0]['start_date'], finish_date: booking[0]['finish_date'], user_id: booking[0]['user_id'], space_id: booking[0]['space_id'])  
    #Create booking in database and wrap in new booking object
  end

  def initialize(id:, start_date:, finish_date:, user_id:, space_id:)
    @id = id
    @space_id = space_id
    @start_date = start_date
    @finish_date = finish_date
    @person_renting = user_id
    @total_nights = duration.to_i
    # p duration.to_i
    # @total_price = total_cost
  end

  def duration
    start_day = start_date.split('-')
    finish_day = finish_date.split('-')
    days = Date.new(finish_day[0].to_i, finish_day[1].to_i, finish_day[2].to_i) - Date.new(start_day[0].to_i, start_day[1].to_i, start_day[2].to_i) 
    return days  
  end

  # def total_cost
  #   if ENV['ENVIRONMENT'] == 'test'
  #     DatabaseConnection.setup('makersbnb_test')
  #   else
  #     DatabaseConnection.setup('makersbnb')
  #   end

  #   space = DatabaseConnection.query("SELECT * FROM spaces WHERE space_id = '#{@space_id}';")
  #   Space.new(id: space['space_id'], name: space['name'], price: space['price'], description: space['description'], image: space['image']) 
  #   @total_nights * space.price
  # end


end