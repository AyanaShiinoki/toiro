class RenameUserImageColumnTo < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :user_image, :user_image_id
  end
end
