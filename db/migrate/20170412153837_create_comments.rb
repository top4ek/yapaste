class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :post, null: false
      t.text       :message, null: false
      t.timestamps
    end
  end
end
