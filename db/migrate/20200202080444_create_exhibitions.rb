class CreateExhibitions < ActiveRecord::Migration[5.2]
  def change
    create_table :exhibitions do |t|
      t.integer :user_id
      t.string :title
      t.text :caption
      t.boolean :is_active, :boolean, default: true, null: false

      t.timestamps
    end
  end
end
