require 'rubygems'
require 'uuid'

class Upload < ActiveRecord::Base
  # Paperclip
  has_attached_file :file, :path => ":rails_root/uploads/:class/:id/:basename.:extension"
  #validates_attachment_presence :file

  validates :download_count, :presence=>true

  belongs_to :folder

  def self.unique_id
    UUID.new.generate
  end
  
end
