class CreateRepositoryTypes < ActiveRecord::Migration
  def self.up
    create_table :repository_types do |t|
      t.column "name",               :string,     :limit => 256,   :null => false
      t.column "created_at",         :datetime,   :null => false
      t.column "updated_at",         :datetime,   :null => false
      t.column "deleted_at",         :datetime,   :null => true
    end
    RepositoryType.new(:name => "none").save
    RepositoryType.new(:name => "svn").save
    RepositoryType.new(:name => "git").save
  end

  def self.down
    drop_table :repository_types
  end
end
