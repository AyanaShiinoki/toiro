class RenameWorkImageColumnToWorks < ActiveRecord::Migration[5.2]
  def change
  	rename_column :works, :work_image, :work_image_id
  end
end
