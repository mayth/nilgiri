class AddDeviseToPlayers < ActiveRecord::Migration
  def change
    change_table(:players) do |t|
      # Remove existing field
      t.remove :screen_name
      t.remove :password

      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
    end

    # `name' is no longer used to authenticate, just for display.
    remove_index :players, :name
    add_index :players, :email,                :unique => true
    add_index :players, :reset_password_token, :unique => true
  end
end
