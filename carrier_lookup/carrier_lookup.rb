require 'typhoeus'
require File.dirname(__FILE__) + '/white_pages_parser'

class CarrierLookup
  def initialize(phone_number)
    @phone_number = phone_number
  end

  def find_carrier
    response = Typhoeus.get("http://www.whitepages.com/phone/#{@phone_number.to_s}").body
    WhitePagesParser.parse(response)
  end

end