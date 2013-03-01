class Request < ActiveRecord::Base
  attr_accessible :date, 
                  :title,
                  :location, 
                  :deadline,
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

  def whichever_date
    if self.date
      return self.date
    end
    return self.deadline
  end

  def expired?
    self.whichever_date < Date.today
  end

  def denied?
    self.receiver_confirmation == false
  end

  def canceled?
    self.sender_confirmation == false
  end

  def pending_acceptance?
    self.receiver_confirmation == nil
  end

  def pending_approval?
    self.receiver_confirmation == true && self.sender_confirmation == nil
  end

  def approved?
    self.receiver_confirmation && self.sender_confirmation
  end  

  def csp
    if self.city && self.state && self.postal_code
      return "#{self.city}, #{self.state}, #{self.postal_code}"
    else
      return self.city
    end
  end

  def self.save_times(times)
    times = times.split(",|,")
    time_hash = {}
    times.each do |t|
      t = t.split(",")
      if time_hash[t[0]]
        time_hash[t[0]] << t[1]
      else
        h = Hash.new
        h[t[0]] = [t[1]]
        time_hash.merge!(h)
      end
    end
    return time_hash.to_s
  end

  def self.update_location(r, location)
    raw_location = location.split(",")
    location = raw_location.last
    address = raw_location.first
    city = raw_location[1]
    r.update_attributes(:location => location,
                        :address => address,
                        :city => city)
  end

  def self.deal_with_message(r, body, id)
    if body != ""
      r.messages.last.update_attributes(:user_id => id)
    elsif body == ""
      r.messages.last.destroy
    end
  end

end
