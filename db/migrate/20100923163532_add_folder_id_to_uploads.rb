class AddFolderIdToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :folder_id, :integer
  end

  def self.down
    remove_column :uploads, :folder_id
  end
end
