class AddIndexesToBabyNames < ActiveRecord::Migration
  def self.up
    add_index :baby_names, :name
    add_index :baby_names, :year
    add_index :baby_names, :gender
  end

  def self.down
    remove_index :baby_names, :column => :gender
    remove_index :baby_names, :column => :year
    remove_index :baby_names, :column => :name
  end
end
