class ChangeSeasonsToReference < ActiveRecord::Migration
  def self.up
    change_table :musics do |t|
      t.remove :season
      t.references :season
    end
    change_table :scores do |t|
      t.remove :season
      t.references :season
    end
  end

  def self.down
    change_table :musics do |t|
      t.remove :season_id
      t.string :season
    end
    change_table :scores do |t|
      t.remove :season
      t.string :season
    end
  end
end
