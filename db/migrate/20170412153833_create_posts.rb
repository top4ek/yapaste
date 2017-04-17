class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text   :snippet, null: false
      t.string :title, null: false
      t.string :name, null: false
      t.references :forked_from, null: true
      t.timestamps
    end
  end
end
