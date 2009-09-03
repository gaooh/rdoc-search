class CreateRubyMethods < ActiveRecord::Migration
  def self.up
    create_table :ruby_methods do |t|
      t.column "library_id",         :integer,    :null => false
      t.column "name",               :string,     :limit => 256,   :null => false
      t.column "filename",           :string,     :limit => 256,   :null => false
      t.column "anchor",             :string,     :limit => 256,   :null => false
      t.column "description",        :text,       :null => true
      t.column "created_at",         :datetime,   :null => false
      t.column "updated_at",         :datetime,   :null => false
      t.column "deleted_at",         :datetime,   :null => true
    end
  end

  def self.down
    drop_table :ruby_methods
  end
end
