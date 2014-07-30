class CarrierEmail
  def initialize(carrier)
    @carrier = carrier
  end

  def email
    puts "found #{@carrier}"
    case @carrier
    when "T-Mobile"
    "tmomail.net"
    when "Verizon"
    "vtext.com"
    when "AT&T"
    "mobile.att.net"
    else
      ""
    end
  end
end