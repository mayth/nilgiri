class AddPlayStyleToScore < ActiveRecord::Migration
  def self.up
    change_table :scores do |t|
      t.string :playstyle
    end
  end

  def self.down
    change_table :scores do |t|
      t.remove :playstyle
    end
  end
end
