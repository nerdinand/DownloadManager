class AddDownloadCountToUploads < ActiveRecord::Migration
  def self.up
    add_column :uploads, :download_count, :integer
  end

  def self.down
    remove_column :uploads, :download_count
  end
end
