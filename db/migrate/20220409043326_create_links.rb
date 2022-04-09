class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :url
      t.string :url_generated

      t.timestamps
    end
    add_index :links, :url_generated, unique: true
  end
end
