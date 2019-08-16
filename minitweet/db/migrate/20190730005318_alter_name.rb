class AlterName < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_infos, :username, :user_name
    rename_column :user_infos, :userid, :user_id
  end
end
