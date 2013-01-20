class Request < ActiveRecord::Base
  attr_accessible :date, 
                  :title,
                  :location, 
                  :receiver_confirmation, 
                  :receiver_id, 
                  :sender_confirmation, 
                  :sender_id, 
                  :start_time,
                  :end_time,
                  :messages_attributes
                  
  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :messages, :allow_destroy => true
  
  def last_reply
    Message.find_all_by_request_id(self.id).last.user
  end
  
  def sent_by
    User.find(self.sender_id).name
  end
  
  def receiver
    User.find(self.receiver_id).name
  end
  
  def pending_approval?
    self.start_time && self.end_time && self.location && (self.sender_confirmation == nil)
  end
  
  def approved?
    self.receiver_confirmation && self.sender_confirmation
  end
  
  
end
