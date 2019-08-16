class CreateUserTexts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_texts do |t|
      t.string :title
      t.text :text
      t.timestamps
    end
  end
end
