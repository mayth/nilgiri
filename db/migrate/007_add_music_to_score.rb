class AddMusicToScore < ActiveRecord::Migration
  def self.up
    change_table :scores do |t|
      t.references :music
    end
  end

  def self.down
    change_table :scores do |t|
      t.remove :music
    end
  end
end
