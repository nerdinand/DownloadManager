module ApplicationHelper

  def all_folders
    Folder.all
  end

  def all_folders_array
    Folder.all.map { |folder| [folder.name, folder.id] }
  end

end
