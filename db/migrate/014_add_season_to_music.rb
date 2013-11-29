class AddSeasonToMusic < ActiveRecord::Migration
  def self.up
    change_table :musics do |t|
      t.string :season
    end
  end

  def self.down
    change_table :musics do |t|
      t.remove :season
    end
  end
end
