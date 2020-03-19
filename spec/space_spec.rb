require 'space'
require 'connect_and_clear_db'

describe Space do

  describe '.all' do
    it 'returns an array of spaces' do
      space = Space.add(name: 'Cool house', price: 100, description: 'Cool house', image: 'www.asdof')
      Space.add(name: 'Moon house', price: 200, description: 'Moon house', image: 'www.asdifh')
      Space.add(name: 'Spacecraft', price: 250, description: 'galaxy-bound house', image: 'https://makersacademyspacebnb.s3.amazonaws.com/falcon.png')

      spaces = Space.all

      expect(spaces.length).to eq 3
      expect(space).to be_a Space
    end
  end

  describe '.add' do
    it 'creates a new space' do
      space = Space.add(name: 'Millenium Falcon', price: 100, description: 'galaxy-bound house', image: 'https://makersacademyspacebnb.s3.amazonaws.com/falcon.png')
      
      connection = PG.connect(dbname: 'makersbnb_test')
      result = connection.exec("SELECT * FROM spaces WHERE space_id = #{space.id};").first

      expect(space).to be_a Space
      expect(space.id).to eq result['space_id']
      expect(result['name']).to eq 'Millenium Falcon'
      expect(result['price']).to eq '100'
      expect(result['description']).to eq 'galaxy-bound house'
      expect(result['image']).to eq 'https://makersacademyspacebnb.s3.amazonaws.com/falcon.png'
    end
  end

end