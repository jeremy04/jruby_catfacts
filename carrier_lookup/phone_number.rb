class PhoneNumber
  PHONE_NUMBER_REGEX = /^\s*[+]? \s*[01]? \s*[\(\-]*\s* (\d{3}) \s*[\)\-]*\s* (\d{3}) \s*[\-]*\s* (\d{4}) \s*(x\s*\d*)?\s*$/ix

  attr_reader :area_code, :exchange, :number, :raw_number

  def initialize(number)
    @raw_number = number
    number =~ PHONE_NUMBER_REGEX
    @area_code, @exchange, @number = $1, $2, $3
  end

  def to_s(format = :white_pages)
    "1-#{@area_code}-#{@exchange}-#{@number}"
  end
end