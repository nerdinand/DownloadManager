class Upload < ActiveRecord::Base
  # Paperclip
  has_attached_file :file
  validates_attachment_presence :file

  belongs_to :folder


end
