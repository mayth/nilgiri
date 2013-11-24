class AddConstraintsToPlayer < ActiveRecord::Migration
  def self.up
    change_column :players, :name, :string, null: false
    change_column :players, :password, :string, null: false
    add_index :players, :name, unique: true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
