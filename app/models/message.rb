class Message < ActiveRecord::Base
  attr_accessible :body, 
                  :receiver_viewed, 
                  :request_id, 
                  :sender_viewed,
                  :user_id
                  
                  
  belongs_to :request
  
  def user
    User.find_by_id(self.user_id).name
  end
end
