# == Schema Information
# Schema version: 3
#
# Table name: repository_types
#
#  id         :integer(11)     not null, primary key
#  name       :string(256)     default(""), not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  deleted_at :datetime        
#

class RepositoryType < ActiveRecord::Base
  acts_as_paranoid
  
  # --------------------------
  # validatie
  # --------------------------
  validates_presence_of :name
  
  def svn?
    self.name == "svn" ? true : false
  end
  
  def git?
    self.name == "git" ? true : false
  end
end
