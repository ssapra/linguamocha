class Request < ActiveRecord::Base
  attr_accessible :date, 
                  :location, 
                  :receiver_confirmation, 
                  :receiver_id, 
                  :sender_confirmation, 
                  :sender_id, 
                  :time
                  
  has_many :messages
end
