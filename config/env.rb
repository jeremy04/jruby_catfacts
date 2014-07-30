require 'yaml'
require 'erb'

class CatSettings
  def self.config
    environment = ENV['CAT_FACTS_MODE'] || "development"
    YAML.load(ERB.new(File.read(File.dirname(__FILE__) + '/cat_facts.yml')).result)[environment]
  end
end
