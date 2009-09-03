# == Schema Information
# Schema version: 3
#
# Table name: libraries
#
#  id                 :integer(11)     not null, primary key
#  name               :string(256)     default(""), not null
#  version            :string(256)     default(""), not null
#  path               :string(256)     default(""), not null
#  repository_type_id :integer(11)     not null
#  url                :string(256)     
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  deleted_at         :datetime        
#

class Library < ActiveRecord::Base
  acts_as_paranoid
  
  # --------------------------
  # relation
  # --------------------------
  belongs_to :repository_type
  
  # --------------------------
  # validatie
  # --------------------------
  validates_presence_of :name, :version, :repository_type_id
  
end
