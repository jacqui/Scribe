Mongoid.configure do |config|
  config.database = Mongo::Connection.new.db("scribe-#{Rails.env}")
end
