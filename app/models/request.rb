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
  
  
  # Google Maps API key: AIzaSyDFXdzd98ckgjQL-ix-2GedGRVvGl9ef-U
  
  # Yelp API v1.0 key: yrOiKALTY0Mw_wBYJVmPwg
  
  # API v2.0
  # Consumer Key  EcxkaDnICiYJE2PZm_OeCw
  # Consumer Secret Yqc_OOMULadnzTs7Juj8bmZN3Ng
  # Token sKXNbkV6k17LqXx3Rjl21BzvpP26O9CF
  # Token Secret  8EuUtxYMsqGD89qtIRkDj-LOXKg
  
  # https://developers.google.com/maps/documentation/javascript/tutorial
  
  # Urban Mapping API key: cb5d8d502a625083c77181341a7a5e5f
  
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
