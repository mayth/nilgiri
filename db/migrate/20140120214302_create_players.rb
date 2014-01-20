class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :screen_name
      t.string :password
      t.string :twitter_id

      t.timestamps
    end
    add_index :players, :name, unique: true
  end
end
