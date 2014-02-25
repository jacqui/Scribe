Mongoid.configure do |config|
  config.database = Mongo::Connection.new.db("scribe-#{Rails.env}")
  #config.database.authenticate(username,password)
end
