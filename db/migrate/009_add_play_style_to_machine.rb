class AddPlayStyleToMachine < ActiveRecord::Migration
  def self.up
    change_table :machines do |t|
      t.string :playstyles
    end
  end

  def self.down
    change_table :machines do |t|
      t.remove :playstyles
    end
  end
end
