require "./config/env"
require "./config/mongo_config"

class CatFact

  def initialize
    @config = CatSettings.config
    @mongo = CatConnection.new(@config).connect_to_mongo
  end

  def download_facts!
    @facts = @mongo.find({_id: BSON::ObjectId(@config['cat_facts_oid'].to_s)}).next
    nil
  end

  def random_fact
    @facts && @facts["facts"].shuffle.first
  end

  def users
    @mongo.find({_id: BSON::ObjectId(@config['users_oid'].to_s)}).next["users"]
  end

end
