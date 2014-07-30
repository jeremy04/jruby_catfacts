require 'rspec'
require "./carrier_lookup/carrier_lookup"
require "./carrier_lookup/phone_number"

describe CarrierLookup do
  
  describe ".find_carrier" do

    it "returns a string of a mobile provider given a phone number" do
      response = double("response", :body => "some html")
      WhitePagesParser.should_receive(:parse).with("some html").and_return("T-Mobile")
      Typhoeus.should_receive(:get).with("http://www.whitepages.com/phone/1-123-456-7890").and_return(response)
      phone_number = PhoneNumber.new("1234567890")
      carrier_lookup = CarrierLookup.new(phone_number)
      carrier_lookup.find_carrier.should == "T-Mobile"
    end
    
  end
end