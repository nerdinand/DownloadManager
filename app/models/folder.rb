class Folder < ActiveRecord::Base

  has_many :uploads
  belongs_to :user
  
end
