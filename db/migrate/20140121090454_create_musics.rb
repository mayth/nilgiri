class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :name
      t.string :artist
      t.references :machine, index: true
      t.references :season, index: true

      t.timestamps
    end
  end
end
