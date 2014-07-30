require 'mongo'

class CatConnection

  def initialize(config)
    @config = config
  end

  def connect_to_mongo
    mongo_uri = "mongodb://#{@config['mongolab_username']}:#{@config['mongolab_password']}@#{@config['mongolab_host']}:#{@config['mongo_port']}/#{@config['mongolab_db']}"
    connection = Mongo::Connection.from_uri(mongo_uri)
    db = connection.db(@config['mongolab_db'])
    db.collection('catfacts')
  end

end