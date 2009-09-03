class CreateLibraries < ActiveRecord::Migration
  def self.up
    create_table :libraries do |t|
      t.column "name",               :string,     :limit => 256,   :null => false
      t.column "version",            :string,     :limit => 256,   :null => false
      t.column "path",               :string,     :limit => 256,   :null => false
      t.column "repository_type_id", :integer,    :null => false
      t.column "url",                :string,     :limit => 256,   :null => true
      t.column "created_at",         :datetime,   :null => false
      t.column "updated_at",         :datetime,   :null => false
      t.column "deleted_at",         :datetime,   :null => true
    end
  end

  def self.down
    drop_table :libraries
  end
end
