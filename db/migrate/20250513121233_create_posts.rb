class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :fish_name
      t.float :fish_size
      t.string :spot
      t.string :spot_detail
      t.datetime :fishing_date
      t.integer :weather
      t.integer :temperature
      t.string :tide
      t.text :comment
      t.text :memo
      t.integer :status
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
