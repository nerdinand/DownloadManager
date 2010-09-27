module ApplicationHelper

  def all_folders
    Folder.where({:folder_id => nil})
  end

  def all_folders_array
    Folder.all.map { |folder| [folder.name, folder.id] }
  end

end
