class AddSlugToMachine < ActiveRecord::Migration
  def self.up
    change_table :machines do |t|
      t.string :slug
    end
  end

  def self.down
    change_table :machines do |t|
      t.remove :slug
    end
  end
end
