class AddName < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_infos, :username, :userid
    add_column :user_infos, :username, :string
  end
end