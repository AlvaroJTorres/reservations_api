class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :role, default: 0
      t.string :facebook_id
      t.string :gmail_id
      
      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
