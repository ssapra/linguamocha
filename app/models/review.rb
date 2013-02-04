class Review < ActiveRecord::Base
  attr_accessible :body, 
                  :request_id, 
                  :vote,
                  :sender_id,
                  :receiver_id
                  
  belongs_to :request
  
  def sent_by
    User.find_by_id(self.sender_id)
  end
  
end
