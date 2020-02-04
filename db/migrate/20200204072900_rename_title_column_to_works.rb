class RenameTitleColumnToWorks < ActiveRecord::Migration[5.2]
  def change
  	rename_column :works, :title, :work_title
  end
end
