class Folder < ActiveRecord::Base

  has_many :uploads
  belongs_to :user

  has_many :folders, :through => "subfolders"
  belongs_to :folder, :through => "parent"
  
end
