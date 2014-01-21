class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :name
      t.string :slug
      t.datetime :start
      t.datetime :expiry

      t.timestamps
    end
    add_index :seasons, :slug, unique: true
  end
end
