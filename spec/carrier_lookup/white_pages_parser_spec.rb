require 'rspec'
require "./carrier_lookup/white_pages_parser"

describe WhitePagesParser do
  
  describe ".parse" do

    it "parses html to correct carrier" do
      WhitePagesParser.parse("<html>Carrier:T-Mobile\s</html>").should == "T-Mobile"
    end

    it "returns nil if Landline is in html" do
      WhitePagesParser.parse("<html><body>Landline Carrier:T-Mobile\s</html>").should be_nil
    end

  end
end