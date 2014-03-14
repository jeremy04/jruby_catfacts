Dir["#{File.expand_path File.dirname(__FILE__)}/jars/*.jar"].each { |jar| require jar }

# Edit classpath for JRuby class loader
# export CLASSPATH=$CLASSPATH:./jars/*

# Run like so:
# jruby --2.0 -S main.rb -Dlog4j.configuration=log4j2.xml

$CLASSPATH << "#{File.dirname(__FILE__)}/log4j2.xml"

module Logging

  def logger
    org.apache.logging.log4j.LogManager.getLogger self.class.to_s
  end

end