class DropMachineFromScore < ActiveRecord::Migration
  def self.up
    change_table :scores do |t|
      t.remove :machine
    end
  end

  def self.down
    t.references :machine
  end
end
