class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :user_id
      t.string :title
      t.boolean :watched, :default => false
      t.timestamps null: false
    end
  end
end
