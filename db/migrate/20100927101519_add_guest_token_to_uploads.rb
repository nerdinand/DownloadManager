class AddGuestTokenToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :guest_token, :string
  end

  def self.down
    remove_column :uploads, :guest_token
  end
end
