class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  attr_accessible :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :url => "/system/:attachment/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension"
                    
  attr_accessible :name, 
                  :bio,
                  :username,
                  :high_school,
                  :college,
                  :degree,
                  :occupation,
                  :my_skills_attributes,
                  :interests_attributes
  
  has_many :my_skills, dependent: :destroy
  has_many :interests, dependent: :destroy
  accepts_nested_attributes_for :my_skills, :allow_destroy => true
  accepts_nested_attributes_for :interests, :allow_destroy => true
  
  def requests
    sent = Request.find_by_sender_id(self.id)
    received = Request.find_by_receiver_id(self.id)
    requests = [sent,received].flatten
    requests.delete_if {|r| r == nil}
  end
end
