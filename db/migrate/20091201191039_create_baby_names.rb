class CreateBabyNames < ActiveRecord::Migration
  def self.up
    create_table :baby_names do |t|
      t.string :name
      t.string :gender
      t.string :year
      t.integer :hispanic_count, :default => 0
      t.integer :hispanic_rank, :default => 0
      t.integer :white_count, :default => 0
      t.integer :white_rank, :default => 0
      t.integer :asian_count, :default => 0
      t.integer :asian_rank, :default => 0
      t.integer :black_count, :default => 0
      t.integer :black_rank, :default => 0
      t.integer :unknown_count, :default => 0
      t.integer :unknown_rank, :default => 0
      t.integer :total_count, :default => 0
      t.integer :total_rank, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :baby_names
  end
end
