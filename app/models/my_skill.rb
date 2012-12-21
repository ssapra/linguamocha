class MySkill < ActiveRecord::Base
  
  attr_accessible :description, :tag, :user_id
  
  validates :tag, :presence => {:message => "Skill tag can't be blank"}
  
  belongs_to :user
end
