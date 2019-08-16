class CreateTokenManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :token_managers do |t|
      t.text :refresh_token
      t.string :user_ip
      t.timestamps
    end
  end
end
