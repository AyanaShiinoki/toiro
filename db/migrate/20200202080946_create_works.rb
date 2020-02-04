class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.references :user, foreign_key: true
      t.references :exhibition, foreign_key: true
      t.string :title
      t.text :description
      t.string :work_image

      t.timestamps
    end
  end
end
