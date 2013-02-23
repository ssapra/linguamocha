class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  attr_accessible :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "30x30>" },
                    :url => "/system/:attachment/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension",
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "/:style/:id/:filename"
                    
  attr_accessible :first_name,
                  :last_name,
                  :bio,
                  :username,
                  :high_school,
                  :college,
                  :degree,
                  :occupation,
                  :zipcode,
                  :city,
                  :state,
                  :my_skills_attributes,
                  :interests_attributes

  validates :name, presence: true
  # validates :username, presence: true, uniqueness: true, format: { with: /^[a-z0-9_-]{6,12}$/,
  #                     message: "must be lowercase letters and numbers" }, length: { in: 6..12, too_short: "must have at least 6 characters",
  #                         too_long: "must have at most 12 characters"}
  
  after_create :set_username

  has_many :my_skills, dependent: :destroy
  has_many :interests, dependent: :destroy
  accepts_nested_attributes_for :my_skills, :allow_destroy => true
  accepts_nested_attributes_for :interests, :allow_destroy => true
  
  
  def sent_requests
    Request.find_all_by_sender_id(self.id).select{|r| r.deadline > Date.today}
  end
  
  def received_requests
    Request.find_all_by_receiver_id(self.id).select{|r| r.deadline > Date.today}
  end
  
  def past_sent_requests
    Request.find_all_by_sender_id(self.id).select{|r| r.deadline < Date.today}
  end
  
  def past_received_requests
    Request.find_all_by_receiver_id(self.id).select{|r| r.deadline < Date.today}    
  end
  
  def requests
    requests = [sent_requests,received_requests].flatten
    requests.delete_if {|r| r == nil}
  end
  
  def name
    self.first_name + " " + self.last_name if self.first_name
  end
  
  def reviews_sent 
    Review.find_all_by_sender_id(self.id)
  end
  
  def reviews_received
    Review.find_all_by_receiver_id(self.id)    
  end
    
  def set_username
    if self.first_name
      self.username = self.first_name.downcase + self.last_name.downcase
      self.save
    else 
      return nil
    end
  end
end
