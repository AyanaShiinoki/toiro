class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.integer :user_id
      t.integer :exhibition_id
      t.string :title
      t.text :description
      t.integer :work_image

      t.timestamps
    end
  end
end
