class AddLockedToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :locked, :boolean
  end

  def self.down
    remove_column :uploads, :locked
  end
end
