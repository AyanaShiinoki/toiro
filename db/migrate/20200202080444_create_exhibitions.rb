class CreateExhibitions < ActiveRecord::Migration[5.2]
  def change
    create_table :exhibitions do |t|
      t.references :user, foreign_key: true
      t.references :gallery, foreign_key: true
      t.string :title
      t.text :caption
      t.boolean :is_active, default: true, null: false

      t.timestamps
    end
  end
end
