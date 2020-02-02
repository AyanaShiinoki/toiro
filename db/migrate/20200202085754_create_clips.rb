class CreateClips < ActiveRecord::Migration[5.2]
  def change
    create_table :clips do |t|
      t.references :folder, foreign_key: true
      t.references :exhibition, foreign_key: true
      t.string :memo
      t.boolean :is_active, default: true, null: false

      t.timestamps
    end
  end
end
