class Upload < ActiveRecord::Base
  # Paperclip
  has_attached_file :file, :path => ":rails_root/uploads/:class/:id/:basename.:extension"
  validates_attachment_presence :file

  belongs_to :folder


end
