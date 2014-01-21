class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :name
      t.string :slug
      t.string :difficulties
      t.string :playstyles

      t.timestamps
    end
    add_index :machines, :slug, unique: true
  end
end
