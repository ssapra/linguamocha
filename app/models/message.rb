class Message < ActiveRecord::Base
  attr_accessible :body, 
                  :receiver_viewed, 
                  :request_id, 
                  :sender_viewed
                  
  belongs_to :request
end
