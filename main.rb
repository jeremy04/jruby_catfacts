require 'java'

Dir["#{File.expand_path File.dirname(__FILE__)}/jars/*.jar"].each { |jar| require jar }


module Logging
  def self.included(base)
    base.extend(ClassMethods)
  end

  def logger
    org.apache.log4j.Logger.getLogger self.class.to_s
  end

  module ClassMethods
    def enable_logging
      org.apache.log4j.PropertyConfigurator.configure "log.properties"
    end

  end
end

class Foo
  include Logging
  enable_logging

  def initialize
    logger.info "WOOO"
  end
end