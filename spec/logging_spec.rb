require 'rspec'
require "logging"

class DummyLogging
  include Logging
end

describe "DummyLogging" do
  it "has a logger" do
    org.apache.logging.log4j.LogManager.should_receive(:getLogger).with("DummyLogging")
    # Test outgoing messages with side affects son. I trust ya getLogger
    foo = DummyLogging.new
    foo.logger
  end
  
end
