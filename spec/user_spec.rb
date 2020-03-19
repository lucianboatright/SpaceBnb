require 'user'
require 'database_helper'

describe User do
  describe '.add' do
    it 'creates a new user' do
      user = User.add(first_name: "John",last_name: "Smith", email: "JS@gmail.com", password: "password123")

      connection = PG.connect(dbname: 'makersbnb_test')
      result = connection.exec("SELECT * FROM users WHERE user_id = #{user.id};").first

      expect(user).to be_a User
      expect(user.id).to eq result['user_id']
      expect(result['first_name']).to eq 'John'
      expect(result['last_name']).to eq 'Smith'
      expect(result['email']).to eq 'JS@gmail.com'
      expect(result['password']).to eq 'password123'
    end
  end


  describe '.all' do
    it 'shows users stored on database' do
      user = User.add(first_name: "John",last_name: "Smith", email: "JS@gmail.com", password: "password123")
      user_2 = User.add(first_name: "John_2",last_name: "Smith_2", email: "JS@gmail.com_2", password: "password123_2")
      expect(User.all.length).to eq 2
    end
  end

  describe '.authenticate' do
    it 'returns a user given a correct username and password, if one exists' do
      user = User.add(first_name: "John",last_name: "Smith", email: "JS@gmail.com", password: "password123")
      authenticated_user = User.authenticate(email: 'JS@gmail.com', password: 'password123')

      expect(authenticated_user.id).to eq user.id
    end
  end
end

