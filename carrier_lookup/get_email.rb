require "./phone_number"
require "./carrier_lookup"
require "./phone_number"
require "./carrier_email"

number = ARGV[0]
carrier = CarrierLookup.new(PhoneNumber.new(number)).find_carrier
puts "#{number}@#{CarrierEmail.new(carrier).email}"
