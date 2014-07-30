require 'htmlentities'

class WhitePagesParser
  def self.parse(response)
    if response =~ /Landline/
      nil
    else
      HTMLEntities.new.decode response.scan(/Carrier\:(.*?)\s/).flatten.map { |x| x.gsub(/<("[^"]*"|'[^']*'|[^'">])*>/, "") }.reject(&:empty?).first
    end
  end
end