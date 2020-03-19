require 'pg'
require_relative 'database_connection'

class Space

  attr_reader :id, :name, :price, :description, :image

  def initialize(id:, name:, price:, description:, image:)
    @id = id
    @name = name
    @price = price
    @description = description
    @image = image
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      DatabaseConnection.setup('makersbnb_test')
    else
      DatabaseConnection.setup('makersbnb')
    end

    result = DatabaseConnection.query("SELECT * FROM spaces")
    result.map do |space|
      Space.new(id: space['space_id'], name: space['name'], price: space['price'], description: space['description'], image: space['image']) 
    end
  end

  def self.add(name:, price:, description:, image:)
    if ENV['ENVIRONMENT'] == 'test'
      DatabaseConnection.setup('makersbnb_test')
    else
      DatabaseConnection.setup('makersbnb')
    end
    
    space = DatabaseConnection.query("INSERT INTO spaces (name, price, description, image) VALUES('#{name}', '#{price}', '#{description}', '#{image}') RETURNING space_id, name, price, description, image;")
    Space.new(id: space[0]['space_id'], name: space[0]['name'], price: space[0]['price'], description: space[0]['description'], image: space[0]['image'])  

  end


  def self.get(space_id:)
    ENV['ENVIRONMENT'] == 'test' ? connection = PG.connect(dbname: 'makersbnb_test') : connection = PG.connect(dbname: 'makersbnb')
    space = connection.exec("SELECT * FROM spaces WHERE space_id = '#{space_id}';")
    Space.new(id: space[0]['space_id'], name: space[0]['name'], price: space[0]['price'], description: space[0]['description'], image: space[0]['image'])  
  end
  def self.price_per
    @price
  end
  


end