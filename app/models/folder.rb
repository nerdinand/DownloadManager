class Folder < ActiveRecord::Base

  has_many :uploads
  belongs_to :user

  has_many :folders
  belongs_to :folder
  
end
