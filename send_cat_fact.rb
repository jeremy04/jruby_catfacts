require 'mandrill'
class SendCatFact
  def self.send_email(to, txt)
    mandrill = Mandrill::API.new ENV['MANDRILL_API_KEY']
    message = {  
     :subject=> "Cat Facts",  
     :from_name=> "Cat Facts",  
     :text=>txt,  
     :to=>[  
       {  
         :email=> to,
         :name=> ""  
       }  
     ],  
     :html=>txt,  
     :from_email=>"catfacts@catfacts.com"  
    }  
    sending = mandrill.messages.send message  
    puts sending
  end
end