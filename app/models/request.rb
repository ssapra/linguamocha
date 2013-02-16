class Request < ActiveRecord::Base
  attr_accessible :date, 
                  :title,
                  :location, 
                  :address,
                  :city,
                  :state,
                  :postal_code,
                  :receiver_confirmation, 
                  :receiver_id, 
                  :sender_confirmation, 
                  :sender_id, 
                  :start_time,
                  :end_time,
                  :times,
                  :messages_attributes
                  
  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :messages, :allow_destroy => true
  
  has_one :review
  
  def last_reply
    Message.find_all_by_request_id(self.id).last.user
  end
  
  def sent_by
    User.find(self.sender_id)
  end
  
  def receiver
    User.find(self.receiver_id)
  end
  
  def pending_approval?
    self.receiver_confirmation == true && self.sender_confirmation == nil
  end
  
  def approved?
    self.receiver_confirmation && self.sender_confirmation
  end  

  def canceled?
    self.sender_confirmation == false
  end

  def csp
    if self.city && self.state && self.postal_code
      return "#{self.city}, #{self.state}, #{self.postal_code}"
    else
      return self.city
    end
  end
  
end
