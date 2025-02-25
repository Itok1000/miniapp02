class CreateNotes < ActiveRecord::Migration[7.2]
  create_table :boards do |t|
    t.string :title, null: false
    t.text   :content, null: false
    t.references :user, foreign_key: true

    t.timestamps
  end
end
