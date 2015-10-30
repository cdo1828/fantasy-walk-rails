class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :full_name
      t.string :fitbit_uid
      t.string :fitbit_token
      t.string :fitbit_secret

      t.timestamps null: false
    end
  end
end
