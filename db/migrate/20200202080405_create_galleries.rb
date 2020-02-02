class CreateGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table :galleries do |t|
      t.references :user, foreign_key: true
      t.string :gallery_name
      t.text :concept

      t.timestamps
    end
  end
end
