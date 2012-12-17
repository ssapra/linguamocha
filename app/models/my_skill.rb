class MySkill < ActiveRecord::Base
  attr_accessible :description, :tag, :user_id
  
  validates :tag, :presence => true
  
  belongs_to :user
end
