require 'pg'
require_relative 'database_connection'

class User

  attr_reader :id, :first_name, :last_name, :email
  
  def initialize(id:, first_name:, last_name:, email:, password:)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @password = password
  end

  def self.add(first_name:, last_name:, email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      DatabaseConnection.setup('makersbnb_test')
    else
      DatabaseConnection.setup('makersbnb')
    end

    user = DatabaseConnection.query("INSERT INTO users (first_name, last_name, email, password) VALUES('#{first_name}', '#{last_name}', '#{email}', '#{password}') RETURNING user_id, first_name, last_name, email, password;")
    User.new(id: user[0]['user_id'], first_name: user[0]['first_name'], last_name: user[0]['last_name'], email: user[0]['email'], password: user[0]['password'])  
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      DatabaseConnection.setup('makersbnb_test')
    else
      DatabaseConnection.setup('makersbnb')
    end
    
    users = DatabaseConnection.query("SELECT * FROM users")
    users.map do |user|
      User.new(id: user['user_id'], first_name: user['first_name'], last_name: user['last_name'], email: user['email'], password: user['password'] )
    end
  end

  def self.authenticate(email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      DatabaseConnection.setup('makersbnb_test')
    else
      DatabaseConnection.setup('makersbnb')
    end

    user = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}'")
    User.new(id: user[0]['user_id'], first_name: user[0]['first_name'], last_name: user[0]['last_name'], email: user[0]['email'], password: user[0]['password'] )
  end
end


