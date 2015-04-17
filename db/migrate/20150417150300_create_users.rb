class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :collar, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false


      t.timestamps
    end

    add_index :users, :session_token, unique: true
    add_index :users, :collar, unique: true
  end
end
