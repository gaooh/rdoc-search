# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 3) do

  create_table "libraries", :force => true do |t|
    t.column "name",               :string,   :limit => 256, :default => "", :null => false
    t.column "version",            :string,   :limit => 256, :default => "", :null => false
    t.column "path",               :string,   :limit => 256, :default => "", :null => false
    t.column "repository_type_id", :integer,                                 :null => false
    t.column "url",                :string,   :limit => 256
    t.column "created_at",         :datetime,                                :null => false
    t.column "updated_at",         :datetime,                                :null => false
    t.column "deleted_at",         :datetime
  end

  create_table "repository_types", :force => true do |t|
    t.column "name",       :string,   :limit => 256, :default => "", :null => false
    t.column "created_at", :datetime,                                :null => false
    t.column "updated_at", :datetime,                                :null => false
    t.column "deleted_at", :datetime
  end

  create_table "ruby_methods", :force => true do |t|
    t.column "library_id",  :integer,                                 :null => false
    t.column "name",        :string,   :limit => 256, :default => "", :null => false
    t.column "filename",    :string,   :limit => 256, :default => "", :null => false
    t.column "anchor",      :string,   :limit => 256, :default => "", :null => false
    t.column "description", :text
    t.column "created_at",  :datetime,                                :null => false
    t.column "updated_at",  :datetime,                                :null => false
    t.column "deleted_at",  :datetime
  end

end