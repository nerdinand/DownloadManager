require 'rubygems'
require 'uuid'

class Upload < ActiveRecord::Base
  # Paperclip
  has_attached_file :file, :path => ":rails_root/uploads/:class/:id/:basename.:extension"
  #validates_attachment_presence :file

  validates :download_count, :presence=>true
  validates :user, :presence=>true
  
  belongs_to :folder
  belongs_to :user

  def self.unique_id
    UUID.new.generate
  end

  def guest_upload?
    !guest_token.nil?
  end
  
end
