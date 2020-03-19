require 'pg'

def connect_and_clear_db
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("TRUNCATE users, spaces, bookings;")

end
