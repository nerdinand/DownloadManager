class AddFolderIdToFolders < ActiveRecord::Migration
  def self.up
    add_column :folders, :folder_id, :integer
  end

  def self.down
    remove_column :folders, :folder_id
  end
end
