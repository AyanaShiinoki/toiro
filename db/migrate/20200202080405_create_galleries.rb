class CreateGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table :galleries do |t|
      t.integer :user_id
      t.string :gallery_name
      t.text :concept

      t.timestamps
    end
  end
end
