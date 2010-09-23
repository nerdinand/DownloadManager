class AddSha1ToUpload < ActiveRecord::Migration
  def self.up
    add_column :uploads, :sha1, :string
  end

  def self.down
    remove_column :uploads, :sha1
  end
end
