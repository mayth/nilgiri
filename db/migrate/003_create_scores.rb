class CreateScores < ActiveRecord::Migration
  def self.up
    create_table :scores do |t|
      t.string :season
      t.string :machine
      t.string :difficulty
      t.float :score
      t.references :player
      t.timestamps
    end
  end

  def self.down
    drop_table :scores
  end
end
