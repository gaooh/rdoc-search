# == Schema Information
# Schema version: 3
#
# Table name: ruby_methods
#
#  id          :integer(11)     not null, primary key
#  library_id  :integer(11)     not null
#  name        :string(256)     default(""), not null
#  filename    :string(256)     default(""), not null
#  anchor      :string(256)     default(""), not null
#  description :text            
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  deleted_at  :datetime        
#

class RubyMethod < ActiveRecord::Base
  acts_as_paranoid
  
  # --------------------------
  # relation
  # --------------------------
  belongs_to :library
  
  # --------------------------
  # validatie
  # --------------------------
  validates_presence_of :library_id, :name, :filename, :anchor
  
end
