class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :playstyle
      t.string :difficulty
      t.integer :score
      t.references :player, index: true
      t.references :music, index: true
      t.references :season, index: true

      t.timestamps
    end
  end
end
