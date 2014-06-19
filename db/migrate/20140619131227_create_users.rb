class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :city
      t.text :about

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
