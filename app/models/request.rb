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
end
