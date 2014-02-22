require 'java'

Dir["#{File.expand_path File.dirname(__FILE__)}/jars/*.jar"].each { |jar| require jar }

# Run like:

# jruby --2.0 -S main.rb -Dlog4j.configuration=log4j2.xml

# or add it to the class path

$CLASSPATH << "#{File.dirname(__FILE__)}/log4j2.xml"

module Logging

  def logger
    org.apache.logging.log4j.LogManager.getLogger self.class.to_s
  end

end

class Foo
  include Logging

  def initialize
    logger.warn "WOOO"
  end
end

Foo.new
