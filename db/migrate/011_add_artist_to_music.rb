class AddArtistToMusic < ActiveRecord::Migration
  def self.up
    change_table :musics do |t|
      t.string :artist
    end
  end

  def self.down
    change_table :musics do |t|
      t.remove :artist
    end
  end
end
