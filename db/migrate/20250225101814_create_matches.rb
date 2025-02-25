class CreateMatches < ActiveRecord::Migration[7.2]
  def change
    create_table :matches do |t|
      t.timestamps
      t.string :title, null: false
      t.text :body, null: false
      t.references :user, foreign_key: true
    end
  end
end
