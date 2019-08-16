class AddColId < ActiveRecord::Migration[5.2]
  def change
    add_column :token_managers, :user_id, :string
    add_column :user_texts, :user_id, :string
  end
end
