require 'booking'
  describe '.all' do
    it 'returns an array of bookings for user' do
      user = User.add(first_name: "John",last_name: "Smith", email: "JS@gmail.com", password: "password123")
      space = Space.add(name: 'Old house', price: 100, description: '1920s house', image: 'https://makersacademyspacebnb.s3.amazonaws.com/falcon.png')
      booking = Booking.add(start_date: '2020-01-01',finish_date: '2020-01-11',user_id: user.id, space_id: space.id)
      bookings = Booking.all(user_id: user.id)
      expect(bookings.length).to eq 1
      expect(booking).to be_a Booking
    end
  end
  describe '.add' do
    it 'creates a new Booking' do
      user = User.add(first_name: "John",last_name: "Smith", email: "JS@gmail.com", password: "password123")
      space = Space.add(name: 'Old house', price: 100, description: '1920s house', image: 'https://makersacademyspacebnb.s3.amazonaws.com/falcon.png')

      booking = Booking.add(start_date: '2020-01-01',finish_date: '2020-01-11',user_id: user.id, space_id: space.id)

      connection = PG.connect(dbname: 'makersbnb_test')
      result = connection.exec("SELECT * FROM bookings WHERE id = #{booking.id};").first
      
      expect(booking).to be_a Booking
      expect(booking.id).to eq result['id']
      expect(result['start_date']).to eq '2020-01-01'
      expect(result['finish_date']).to eq '2020-01-11'
      expect(result['user_id']).to eq user.id
      expect(result['space_id']).to eq space.id
    end
  end
  describe '.duration' do
    it 'return difference in days from start to finish' do
      user = User.add(first_name: "John",last_name: "Smith", email: "JS@gmail.com", password: "password123")
      space = Space.add(name: 'Old house', price: 100, description: '1920s house', image: 'https://makersacademyspacebnb.s3.amazonaws.com/falcon.png')

      booking = Booking.add(start_date: '2020-01-25',finish_date: '2020-02-4',user_id: user.id, space_id: space.id)
      connection = PG.connect(dbname: 'makersbnb_test')
      result = connection.exec("SELECT * FROM bookings WHERE id = #{booking.id};").first

      expect(booking.duration).to eq(10)
    end



  # describe '.total_cost' do
  #   it 'returns total price for the whole stay' do
  #   user = User.add(first_name: "John",last_name: "Smith", email: "JS@gmail.com", password: "password123")
  #   space = Space.add(name: 'Old house', price: 100, description: '1920s house', image: 'https://makersacademyspacebnb.s3.amazonaws.com/falcon.png')

  #   booking = Booking.add(start_date: '2020-01-01',finish_date: '2020-01-11',user_id: user.id, space_id: space.id)
  #   connection = PG.connect(dbname: 'makersbnb_test')
  #   result = connection.exec("SELECT * FROM bookings WHERE id = #{booking.id};").first

  #   expect(booking.total_cost).to eq (1000)
      
  #   end
    
  # end

end