class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.references :user, null: true, foreign_key: true
      t.timestamp :deleted_at

      t.timestamps
    end

    add_index :restaurants, :name, unique: true
  end
end
