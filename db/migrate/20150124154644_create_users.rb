class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :first_name, :last_name, :password_digest
      t.timestamps null: false
    end
  end
end
