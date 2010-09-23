require 'digest/sha1'

class UserModelBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection(ActiveRecord::Base.configurations["redmine"])
end

class User < UserModelBase
  def self.authenticate(login, pass)
    u=find(:first, :conditions=>["login = ?", login])
    return nil if u.nil?
    return u if Digest::SHA1.hexdigest(pass)==u.hashed_password
    nil
  end
end

 User.inheritance_column=nil